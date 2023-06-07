import 'package:amplify_trips_planner/common/navigation/router/routes.dart';
import 'package:amplify_trips_planner/common/utils/date_time_formatter.dart';
import 'package:amplify_trips_planner/features/activity/controller/activities_list.dart';
import 'package:amplify_trips_planner/features/activity/ui/activity_category_icon.dart';
import 'package:amplify_trips_planner/models/ModelProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:timelines/timelines.dart';

class ActivitiesList extends ConsumerWidget {
  const ActivitiesList({
    required this.trip,
    super.key,
  });
  final Trip trip;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activitiesListValue = ref.watch(activitiesListProvider(trip.id));

    return activitiesListValue.when(
      data: (activities) => activities.isEmpty
          ? const Center(
              child: Text('No Activities'),
            )
          : Column(
              children: [
                Flexible(
                  child: Timeline.tileBuilder(
                    builder: TimelineTileBuilder.fromStyle(
                      oppositeContentsBuilder: (context, index) {
                        return InkWell(
                          onTap: () => context.goNamed(
                            AppRoute.activity.name,
                            pathParameters: {'id': activities[index].id},
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: ActivityCategoryIcon(
                              activityCategory: activities[index].category,
                            ),
                          ),
                        );
                      },
                      contentsAlign: ContentsAlign.alternating,
                      contentsBuilder: (context, index) => InkWell(
                        onTap: () => context.goNamed(
                          AppRoute.activity.name,
                          pathParameters: {'id': activities[index].id},
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            children: [
                              Text(
                                activities[index].activityName,
                                style: Theme.of(context).textTheme.titleMedium,
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                activities[index]
                                    .activityDate
                                    .getDateTime()
                                    .format('yyyy-MM-dd'),
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              Text(
                                activities[index]
                                    .activityTime!
                                    .getDateTime()
                                    .format('hh:mm a'),
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ),
                      itemCount: activities.length,
                    ),
                  ),
                ),
              ],
            ),
      error: (e, st) => const Center(
        child: Text('Error'),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
