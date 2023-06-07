import 'dart:io';

import 'package:amplify_trips_planner/common/navigation/router/routes.dart';
import 'package:amplify_trips_planner/common/ui/upload_progress_dialog.dart';
import 'package:amplify_trips_planner/common/utils/colors.dart' as constants;
import 'package:amplify_trips_planner/common/utils/date_time_formatter.dart';
import 'package:amplify_trips_planner/features/activity/controller/activities_list.dart';
import 'package:amplify_trips_planner/features/activity/controller/activity_controller.dart';
import 'package:amplify_trips_planner/features/activity/ui/activity_category_icon.dart';
import 'package:amplify_trips_planner/features/activity/ui/activity_page/delete_activity_dialog.dart';
import 'package:amplify_trips_planner/models/ModelProvider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class ActivityPage extends ConsumerWidget {
  const ActivityPage({
    required this.activityId,
    super.key,
  });

  final String activityId;

  Future<bool> deleteActivity(
    BuildContext context,
    WidgetRef ref,
    Activity activity,
  ) async {
    var value = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return const DeleteActivityDialog();
      },
    );
    value ??= false;

    if (value) {
      await ref
          .watch(activitiesListProvider(activity.trip.id).notifier)
          .removeActivity(activity);
    }

    return value;
  }

  Future<void> openFile({
    required BuildContext context,
    required WidgetRef ref,
    required Activity activity,
  }) async {
    final fileUrl = await ref
        .watch(activityControllerProvider(activity.id).notifier)
        .getFileUrl(activity);

    final url = Uri.parse(fileUrl);
    await launchUrl(url);
  }

  Future<bool> uploadFile({
    required BuildContext context,
    required WidgetRef ref,
    required Activity activity,
  }) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'png'],
    );

    if (result == null) {
      return false;
    }

    final platformFile = result.files.first;

    final file = File(platformFile.path!);
    if (context.mounted) {
      showDialog<String>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const UploadProgressDialog();
        },
      ).ignore();
      await ref
          .watch(activityControllerProvider(activity.id).notifier)
          .uploadFile(file, activity);
    }
    return true;
  }

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
      body: activityValue.when(
        data: (activity) => ListView(
          children: [
            Card(
              child: ListTile(
                leading:
                    ActivityCategoryIcon(activityCategory: activity.category),
                title: Text(
                  activity.activityName,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                subtitle: Text(activity.category.name),
              ),
            ),
            ListTile(
              dense: true,
              title: Text(
                'Activity Date',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: Colors.white),
              ),
              tileColor: Colors.grey,
            ),
            Card(
              child: ListTile(
                title: Text(
                  activity.activityDate.getDateTime().format('EE MMMM dd'),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                subtitle: Text(
                  activity.activityTime!.getDateTime().format('hh:mm a'),
                ),
              ),
            ),
            ListTile(
              dense: true,
              title: Text(
                'Documents',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: Colors.white),
              ),
              tileColor: Colors.grey,
            ),
            Card(
              child: activity.activityImageUrl != null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 20),
                          ),
                          onPressed: () {
                            openFile(
                              context: context,
                              ref: ref,
                              activity: activity,
                            );
                          },
                          child: const Text('Open'),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 20),
                          ),
                          onPressed: () {
                            uploadFile(
                              context: context,
                              activity: activity,
                              ref: ref,
                            ).then((value) {
                              Navigator.of(context, rootNavigator: true).pop();
                            });
                          },
                          child: const Text('Replace'),
                        ),
                      ],
                    )
                  : ListTile(
                      title: TextButton(
                        style: TextButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 20),
                        ),
                        onPressed: () {
                          uploadFile(
                            context: context,
                            activity: activity,
                            ref: ref,
                          ).then(
                            (value) => value ? context.pop() : null,
                          );
                          // Navigator.of(context, rootNavigator: true)
                          //     .pop());
                        },
                        child: const Text('Attach a PDF or photo'),
                      ),
                    ),
            ),
            const ListTile(
              dense: true,
              tileColor: Colors.grey,
              visualDensity: VisualDensity(vertical: -4),
            ),
            Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      context.goNamed(
                        AppRoute.editActivity.name,
                        pathParameters: {'id': activity.id},
                        extra: activity,
                      );
                    },
                    child: const Text('Edit'),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      deleteActivity(context, ref, activity).then(
                        (value) {
                          if (value) {
                            context.goNamed(
                              AppRoute.trip.name,
                              pathParameters: {'id': activity.trip.id},
                            );
                          }
                        },
                      );
                    },
                    child: const Text('Delete'),
                  ),
                ],
              ),
            )
          ],
        ),
        error: (e, st) => const Center(
          child: Text('Error'),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
