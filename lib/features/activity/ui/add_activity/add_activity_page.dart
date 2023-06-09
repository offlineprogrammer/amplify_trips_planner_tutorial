import 'package:amplify_trips_planner/common/navigation/router/routes.dart';
import 'package:amplify_trips_planner/common/utils/colors.dart' as constants;
import 'package:amplify_trips_planner/features/activity/ui/add_activity/add_activity_form.dart';
import 'package:amplify_trips_planner/features/trip/controller/trip_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AddActivityPage extends ConsumerWidget {
  AddActivityPage({
    required this.tripId,
    super.key,
  });

  final String tripId;

  final formGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tripValue = ref.watch(tripControllerProvider(tripId));

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Amplify Trips Planner',
        ),
        leading: IconButton(
          onPressed: () {
            context.goNamed(
              AppRoute.trip.name,
              pathParameters: {'id': tripId},
            );
          },
          icon: const Icon(Icons.arrow_back),
        ),
        backgroundColor: const Color(constants.primaryColorDark),
      ),
      body: AddActivityForm(
        trip: tripValue,
      ),
    );
  }
}
