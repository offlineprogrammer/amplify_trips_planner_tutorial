import 'package:amplify_trips_planner/features/activity/services/activities_api_service.dart';
import 'package:amplify_trips_planner/models/ModelProvider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final activitiesRepositoryProvider = Provider<ActivitiesRepository>((ref) {
  ActivitiesAPIService activitiesAPIService =
      ref.read(activitiesAPIServiceProvider);
  return ActivitiesRepository(activitiesAPIService);
});

class ActivitiesRepository {
  ActivitiesRepository(
    this.activitiesAPIService,
  );

  final ActivitiesAPIService activitiesAPIService;

  Future<List<Activity>> getActivitiesForTrip(String tripId) {
    return activitiesAPIService.getActivitiesForTrip(tripId);
  }

  Future<Activity> getActivity(String activityId) {
    return activitiesAPIService.getActivity(activityId);
  }

  Future<void> add(Activity activity) async {
    await activitiesAPIService.addActivity(activity);
  }

  Future<void> delete(Activity activity) async {
    await activitiesAPIService.deleteActivity(activity);
  }
}
