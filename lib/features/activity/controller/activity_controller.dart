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
    return activitiesRepository.getActivity(activityId);
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
        activityImageKey: fileKey,
        activityImageUrl: imageUrl,
      );
      await updateActivity(updatedActivity);
      ref.read(storageServiceProvider).resetUploadProgress();
    }
  }

  Future<String> getFileUrl(Activity activity) async {
    final fileKey = activity.activityImageKey;

    return ref.read(storageServiceProvider).getImageUrl(fileKey!);
  }

  ValueNotifier<double> uploadProgress() {
    return ref.read(storageServiceProvider).getUploadProgress();
  }

  Future<void> updateActivity(Activity activity) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final activitiesRepository = ref.read(activitiesRepositoryProvider);
      await activitiesRepository.update(activity);
      return _fetchActivity(activity.id);
    });
  }
}
