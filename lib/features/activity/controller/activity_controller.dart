import 'dart:io';

import 'package:amplify_trips_planner/common/services/storage_service.dart';
import 'package:amplify_trips_planner/features/activity/data/activities_repository.dart';
import 'package:amplify_trips_planner/models/ModelProvider.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'activity_controller.g.dart';

@riverpod
class ActivityController extends _$ActivityController {
  Future<Activity> _fetchActivity(String activityId) async {
    final activitiesRepository = ref.read(activitiesRepositoryProvider);
    return await activitiesRepository.getActivity(activityId);
  }

  @override
  FutureOr<Activity> build(String activityId) async {
    return _fetchActivity(activityId);
  }

  Future<void> uploadFile(File file, Activity activity) async {
    final fileKey = await ref.read(storageServiceProvider).uploadFile(file);
    if (fileKey != null) {
      final imageUrl =
          await ref.read(storageServiceProvider).getImageUrl(fileKey);
      final updatedActivity = activity.copyWith(
          activityImageKey: fileKey, activityImageUrl: imageUrl);
      // await ref.read(activitiesRepositoryProvider).update(updatedActivity);
      ref.read(storageServiceProvider).resetUploadProgress();
    }
  }

  Future<String> getFileUrl(Activity activity) async {
    final fileKey = activity.activityImageKey;

    return await ref.read(storageServiceProvider).getImageUrl(fileKey!);
  }

//   Future<Activity> getActivity(String id) {
// //return ref.read(activitiesRepositoryProvider).getActivity(id);
//   }

//   Stream<Activity> listenToActivity(String activityId) {
//     return ref.read(activitiesRepositoryProvider).listenToActivity(activityId);
//   }

  ValueNotifier<double> uploadProgress() {
    return ref.read(storageServiceProvider).getUploadProgress();
  }

  Future<void> edit(Activity updatedActivity) async {
    // await ref.read(activitiesRepositoryProvider).update(updatedActivity);
  }

  Future<void> delete(Activity deletedActivity) async {
    // await ref.read(activitiesRepositoryProvider).delete(deletedActivity);
  }
}
