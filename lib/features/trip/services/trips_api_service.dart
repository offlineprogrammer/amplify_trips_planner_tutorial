import 'dart:async';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_trips_planner/models/Trip.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final tripsAPIServiceProvider = Provider<TripsAPIService>((ref) {
  final service = TripsAPIService();
  return service;
});

class TripsAPIService {
  TripsAPIService();

  Future<List<Trip>> getTrips() async {
    try {
      final request = ModelQueries.list(Trip.classType);
      final response = await Amplify.API.query(request: request).response;

      final todos = response.data?.items;
      if (todos == null) {
        safePrint('errors: ${response.errors}');
        return const [];
      }
      return todos.map((e) => e as Trip).toList();
    } on ApiException catch (e) {
      safePrint('Query failed: $e');
      return const [];
    }
  }

  Future<void> addTrip(Trip trip) async {
    try {
      final request = ModelMutations.create(trip);
      final response = await Amplify.API.mutate(request: request).response;

      final createdTrip = response.data;
      if (createdTrip == null) {
        safePrint('errors: ${response.errors}');
        return;
      }
      safePrint('Mutation result: ${createdTrip.tripName}');
    } on Exception catch (error) {
      debugPrint(error.toString());
    }
  }

  Future<void> deleteTrip(Trip trip) async {
    try {
      print('deleteTrip: ${trip.tripName}');
      final response = await Amplify.API
          .mutate(
            request: ModelMutations.delete(trip),
          )
          .response;
      safePrint('Response: $response');
    } on Exception catch (error) {
      debugPrint(error.toString());
    }
  }

  Future<void> updateTrip(Trip updatedTrip) async {
    try {
      // final tripsWithId = await Amplify.DataStore.query(
      //   Trip.classType,
      //   where: Trip.ID.eq(updatedTrip.id),
      // );

      // final oldTrip = tripsWithId.first;
      // final newTrip = oldTrip.copyWith(
      //   tripName: updatedTrip.tripName,
      //   destination: updatedTrip.destination,
      //   startDate: updatedTrip.startDate,
      //   endDate: updatedTrip.endDate,
      //   tripImageKey: updatedTrip.tripImageKey,
      //   tripImageUrl: updatedTrip.tripImageUrl,
      // );

      // await Amplify.DataStore.save(newTrip);
    } on Exception catch (error) {
      debugPrint(error.toString());
    }
  }
}
