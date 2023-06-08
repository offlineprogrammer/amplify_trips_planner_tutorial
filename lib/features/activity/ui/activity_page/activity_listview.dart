import 'dart:io';

import 'package:amplify_trips_planner/common/navigation/router/routes.dart';
import 'package:amplify_trips_planner/common/ui/upload_progress_dialog.dart';
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

class ActivityListView extends ConsumerWidget {
  const ActivityListView({
    required this.activity,
    super.key,
  });

  final AsyncValue<Activity> activity;

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
      await showDialog<String>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const UploadProgressDialog();
        },
      );
      await ref
          .watch(activityControllerProvider(activity.id).notifier)
          .uploadFile(file, activity);
    }
    return true;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    switch (activity) {
      case AsyncData(:final value):
        return ListView(
          children: [
            Card(
              child: ListTile(
                leading: ActivityCategoryIcon(activityCategory: value.category),
                title: Text(
                  value.activityName,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                subtitle: Text(value.category.name),
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
                  value.activityDate.getDateTime().format('EE MMMM dd'),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                subtitle: Text(
                  value.activityTime!.getDateTime().format('hh:mm a'),
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
              child: value.activityImageUrl != null
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
                              activity: value,
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
                              activity: value,
                              ref: ref,
                            ).then(
                              (isUploaded) => isUploaded ? context.pop() : null,
                            );
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
                            activity: value,
                            ref: ref,
                          ).then(
                            (isUploaded) => isUploaded ? context.pop() : null,
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
                        pathParameters: {'id': value.id},
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
                      deleteActivity(context, ref, value).then(
                        (isDeleted) {
                          if (isDeleted) {
                            context.goNamed(
                              AppRoute.trip.name,
                              pathParameters: {'id': value.trip.id},
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
        );

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
