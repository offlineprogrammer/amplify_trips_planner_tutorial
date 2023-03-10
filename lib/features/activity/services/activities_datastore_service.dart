import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_trips_planner/models/Activity.dart';
import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

final activitiesDataStoreServiceProvider =
    Provider<ActivitiesDataStoreService>((ref) {
  final service = ActivitiesDataStoreService();
  return service;
});

class ActivitiesDataStoreService {
  ActivitiesDataStoreService();

  Stream<List<Activity>> listenToActivitiesForTrip(String tripId) {
    return Amplify.DataStore.observeQuery(
      Activity.classType,
      sortBy: [
        Activity.ACTIVITYDATE.ascending(),
        Activity.ACTIVITYTIME.ascending()
      ],
    )
        .map((event) =>
            event.items.where((element) => element.trip.id == tripId).toList())
        .handleError(
      (dynamic error) {
        debugPrint('listenToActivitiesForTrip: A Stream error happened');
      },
    );
  }

  Stream<Activity> listenToActivity(String id) {
    return Amplify.DataStore.observeQuery(
      Activity.classType,
      sortBy: [Activity.ACTIVITYDATE.ascending()],
    )
        .map((event) => event.items.where((element) => element.id == id).first)
        .handleError(
      (dynamic error) {
        debugPrint('listenToActivity: A Stream error happened');
      },
    );
  }

  Future<Activity> getActivity(String id) async {
    final activitiesWithId = await Amplify.DataStore.query(
      Activity.classType,
      where: Activity.ID.eq(id),
    );

    return activitiesWithId.first;
  }

  Future<void> addActivity(Activity activity) async {
    try {
      await Amplify.DataStore.save(activity);
    } on Exception catch (error) {
      debugPrint(error.toString());
    }
  }

  Future<void> deleteActivity(Activity activity) async {
    try {
      await Amplify.DataStore.delete(activity);
    } on Exception catch (error) {
      debugPrint(error.toString());
    }
  }

  Future<void> updateActivity(Activity updatedActivity) async {
    try {
      final activitiesWithId = await Amplify.DataStore.query(
        Activity.classType,
        where: Activity.ID.eq(updatedActivity.id),
      );

      final oldActivity = activitiesWithId.first;
      final newActivity = oldActivity.copyWith(
          activityName: updatedActivity.activityName,
          activityDate: updatedActivity.activityDate,
          category: updatedActivity.category,
          activityTime: updatedActivity.activityTime,
          activityImageKey: updatedActivity.activityImageKey,
          activityImageUrl: updatedActivity.activityImageUrl);

      await Amplify.DataStore.save(newActivity);
    } on Exception catch (error) {
      debugPrint(error.toString());
    }
  }
}
