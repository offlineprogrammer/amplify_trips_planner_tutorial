import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:amplify_trips_planner/common/services/storage_service.dart';
import 'package:amplify_trips_planner/features/activity/data/activities_repository.dart';
import 'package:amplify_trips_planner/models/ModelProvider.dart';

final activityControllerProvider = Provider<ActivityController>((ref) {
  return ActivityController(ref);
});

final activityProvider =
    StreamProvider.autoDispose.family<Activity, String>((ref, activityId) {
  final activityProvider = ref.watch(activityControllerProvider);
  return activityProvider.listenToActivity(activityId);
});

final activityFutureProvider =
    FutureProvider.autoDispose.family<Activity, String>((ref, activityId) {
  final activityProvider = ref.watch(activityControllerProvider);
  return activityProvider.getActivity(activityId);
});

class ActivityController {
  ActivityController(this.ref);
  final Ref ref;

  Future<void> uploadFile(File file, Activity activity) async {
    final fileKey = await ref.read(storageServiceProvider).uploadFile(file);
    if (fileKey != null) {
      final imageUrl =
          await ref.read(storageServiceProvider).getImageUrl(fileKey);
      final updatedActivity = activity.copyWith(
          activityImageKey: fileKey, activityImageUrl: imageUrl);
      await ref.read(activitiesRepositoryProvider).update(updatedActivity);
      ref.read(storageServiceProvider).resetUploadProgress();
    }
  }

  Future<String> getFileUrl(Activity activity) async {
    final fileKey = activity.activityImageKey;

    return await ref.read(storageServiceProvider).getImageUrl(fileKey!);
  }

  Future<Activity> getActivity(String id) {
    return ref.read(activitiesRepositoryProvider).getActivity(id);
  }

  Stream<Activity> listenToActivity(String activityId) {
    return ref.read(activitiesRepositoryProvider).listenToActivity(activityId);
  }

  ValueNotifier<double> uploadProgress() {
    return ref.read(storageServiceProvider).getUploadProgress();
  }

  Future<void> edit(Activity updatedActivity) async {
    await ref.read(activitiesRepositoryProvider).update(updatedActivity);
  }

  Future<void> delete(Activity deletedActivity) async {
    await ref.read(activitiesRepositoryProvider).delete(deletedActivity);
  }
}
