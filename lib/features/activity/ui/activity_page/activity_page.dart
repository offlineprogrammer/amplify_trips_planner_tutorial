import 'package:amplify_trips_planner/common/navigation/router/routes.dart';
import 'package:amplify_trips_planner/common/utils/colors.dart' as constants;
import 'package:amplify_trips_planner/features/activity/controller/activity_controller.dart';
import 'package:amplify_trips_planner/features/activity/ui/activity_page/activity_listview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ActivityPage extends ConsumerWidget {
  const ActivityPage({
    required this.activityId,
    super.key,
  });

  final String activityId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activityValue = ref.watch(activityControllerProvider(activityId));

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Amplify Trips Planner',
        ),
        leading: activityValue.when(
          data: (activity) => IconButton(
            onPressed: () {
              context.goNamed(
                AppRoute.trip.name,
                pathParameters: {'id': activity.trip.id},
              );
            },
            icon: const Icon(Icons.arrow_back),
          ),
          error: (e, st) => const Placeholder(),
          loading: () => const SizedBox(),
        ),
        backgroundColor: const Color(constants.primaryColorDark),
      ),
      body: ActivityListView(
        activity: activityValue,
      ),
    );
  }
}
