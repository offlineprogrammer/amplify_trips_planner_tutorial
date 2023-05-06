import 'dart:async';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_trips_planner/features/activity/data/activities_repository.dart';
import 'package:amplify_trips_planner/models/ModelProvider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'activities_list.g.dart';

@riverpod
class ActivitiesList extends _$ActivitiesList {
  Future<List<Activity>> _fetchActivities(String tripId) async {
    final activitiesRepository = ref.read(activitiesRepositoryProvider);
    final activities = await activitiesRepository.getActivitiesForTrip(tripId);
    return activities;
  }

  @override
  FutureOr<List<Activity>> build(String tripId) async {
    return _fetchActivities(tripId);
  }

  Future<void> add({
    required String name,
    required String activityDate,
    required TimeOfDay activityTime,
    required ActivityCategory category,
    required Trip trip,
  }) async {
    final now = DateTime.now();
    final time = DateTime(
        now.year, now.month, now.day, activityTime.hour, activityTime.minute);
    final format = DateFormat("HH:mm:ss.sss");

    Activity activity = Activity(
      activityName: name,
      activityDate: TemporalDate(DateTime.parse(activityDate)),
      activityTime: TemporalTime.fromString(format.format(time)),
      trip: trip,
      category: category,
    );

    final activitiesRepository = ref.read(activitiesRepositoryProvider);

    await activitiesRepository.add(activity);
  }
}
