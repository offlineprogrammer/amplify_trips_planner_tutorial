import 'dart:async';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_trips_planner/models/ModelProvider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    } on Exception catch (error) {
      safePrint('getActivitiesForTrip failed: $error');
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
    } on Exception catch (error) {
      safePrint('addActivity failed: $error');
    }
  }

  Future<void> deleteActivity(Activity activity) async {
    try {
      await Amplify.API
          .mutate(
            request: ModelMutations.delete(activity),
          )
          .response;
    } on Exception catch (error) {
      safePrint('deleteActivity failed: $error');
    }
  }

  Future<void> updateActivity(Activity updatedActivity) async {
    try {
      await Amplify.API
          .mutate(
            request: ModelMutations.update(updatedActivity),
          )
          .response;
    } on Exception catch (error) {
      safePrint('updateActivity failed: $error');
    }
  }

  Future<Activity> getActivity(String activityId) async {
    try {
      final request = ModelQueries.get(
        Activity.classType,
        ActivityModelIdentifier(id: activityId),
      );
      final response = await Amplify.API.query(request: request).response;

      final activity = response.data!;
      return activity;
    } on Exception catch (error) {
      safePrint('getActivity failed: $error');
      throw Exception;
    }
  }
}
