import 'dart:async';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_trips_planner/models/ModelProvider.dart';
import 'package:amplify_trips_planner/models/Trip.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final activitiesAPIServiceProvider = Provider<ActivitiesAPIService>((ref) {
  final service = ActivitiesAPIService();
  return service;
});

class ActivitiesAPIService {
  ActivitiesAPIService();

  Future<List<Activity>> getActivitiesForTrip(String tripId) async {
    try {
      final request = ModelQueries.list(
        Activity.classType,
        where: Activity.TRIP.eq(tripId),
      );

      final response = await Amplify.API.query(request: request).response;

      final activites = response.data?.items;
      if (activites == null) {
        safePrint('errors: ${response.errors}');
        return const [];
      }
      activites.sort((a, b) => a!.activityDate
          .getDateTime()
          .compareTo(b!.activityDate.getDateTime()));
      return activites.map((e) => e as Activity).toList();
    } on ApiException catch (e) {
      safePrint('Query failed: $e');
      return const [];
    }
  }

  Future<List<Trip>> getPastTrips() async {
    try {
      final request = ModelQueries.list(Trip.classType);
      final response = await Amplify.API.query(request: request).response;

      final trips = response.data?.items;
      if (trips == null) {
        safePrint('errors: ${response.errors}');
        return const [];
      }
      trips.sort((a, b) =>
          a!.startDate.getDateTime().compareTo(b!.startDate.getDateTime()));
      return trips
          .map((e) => e as Trip)
          .where((element) =>
              element.endDate.getDateTime().isBefore(DateTime.now()))
          .toList();
    } on ApiException catch (e) {
      safePrint('Query failed: $e');
      return const [];
    }
  }

  Future<void> addActivity(Activity activity) async {
    try {
      final request = ModelMutations.create(activity);
      final response = await Amplify.API.mutate(request: request).response;

      final createdActivity = response.data;
      if (createdActivity == null) {
        safePrint('errors: ${response.errors}');
        return;
      }
      safePrint('Mutation result: ${createdActivity.activityName}');
    } on Exception catch (error) {
      debugPrint(error.toString());
    }
  }

  Future<void> deleteTrip(Trip trip) async {
    try {
      await Amplify.API
          .mutate(
            request: ModelMutations.delete(trip),
          )
          .response;
    } on Exception catch (error) {
      debugPrint(error.toString());
    }
  }

  Future<void> updateTrip(Trip updatedTrip) async {
    try {
      await Amplify.API
          .mutate(
            request: ModelMutations.update(updatedTrip),
          )
          .response;
    } on Exception catch (error) {
      debugPrint(error.toString());
    }
  }

  Future<Trip> getTrip(String tripId) async {
    try {
      final request = ModelQueries.get(
        Trip.classType,
        TripModelIdentifier(id: tripId),
      );
      final response = await Amplify.API.query(request: request).response;

      final trip = response.data!;
      return trip;
    } on ApiException catch (e) {
      safePrint('Query failed: $e');
      throw Exception;
    }
  }
}
