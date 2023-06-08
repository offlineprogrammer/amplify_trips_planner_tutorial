import 'package:amplify_trips_planner/features/activity/controller/activities_list.dart';
import 'package:amplify_trips_planner/features/activity/ui/activities_list/activities_timeline.dart';
import 'package:amplify_trips_planner/models/ModelProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ActivitiesList extends ConsumerWidget {
  const ActivitiesList({
    required this.trip,
    super.key,
  });
  final Trip trip;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activitiesListValue = ref.watch(activitiesListProvider(trip.id));
    switch (activitiesListValue) {
      case AsyncData(:final value):
        return value.isEmpty
            ? const Center(
                child: Text('No Activities'),
              )
            : ActivitiesTimeline(activities: value);

      case AsyncError():
        return const Center(
          child: Text('Error'),
        );
      case AsyncLoading():
        return const Center(
          child: CircularProgressIndicator(),
        );

      case _:
        return const Center(
          child: Text('Error'),
        );
    }
  }
}
