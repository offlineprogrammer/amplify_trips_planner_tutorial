import 'package:amplify_trips_planner/common/navigation/router/routes.dart';
import 'package:amplify_trips_planner/common/utils/colors.dart' as constants;
import 'package:amplify_trips_planner/models/ModelProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class TripPageFloatingButton extends StatelessWidget {
  const TripPageFloatingButton({
    required this.trip,
    super.key,
  });

  final AsyncValue<Trip> trip;

  @override
  Widget build(BuildContext context) {
    switch (trip) {
      case AsyncData(:final value):
        return FloatingActionButton(
          onPressed: () {
            context.goNamed(
              AppRoute.addActivity.name,
              pathParameters: {'id': value.id},
            );
          },
          backgroundColor: const Color(constants.primaryColorDark),
          child: const Icon(Icons.add),
        );

      case AsyncError():
        return const Placeholder();
      case AsyncLoading():
        return const SizedBox();

      case _:
        return const SizedBox();
    }
  }
}
