import 'package:amplify_trips_planner/common/navigation/router/routes.dart';
import 'package:amplify_trips_planner/models/ModelProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ActivityPageAppBarIcon extends StatelessWidget {
  const ActivityPageAppBarIcon({
    super.key,
    required this.activity,
  });

  final AsyncValue<Activity> activity;

  @override
  Widget build(BuildContext context) {
    switch (activity) {
      case AsyncData(:final value):
        return IconButton(
          onPressed: () {
            context.goNamed(
              AppRoute.trip.name,
              pathParameters: {'id': value.trip.id},
            );
          },
          icon: const Icon(Icons.arrow_back),
        );

      case AsyncError():
        return const Placeholder();
      case AsyncLoading():
        return const SizedBox();

      case _:
        return const Center(
          child: Text('Error'),
        );
    }
  }
}
