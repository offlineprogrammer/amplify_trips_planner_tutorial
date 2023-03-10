import 'package:amplify_trips_planner/features/activity/services/activities_datastore_service.dart';
import 'package:amplify_trips_planner/models/ModelProvider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final activitiesRepositoryProvider = Provider<ActivitiesRepository>((ref) {
  ActivitiesDataStoreService activitiesDataStoreService =
      ref.read(activitiesDataStoreServiceProvider);
  return ActivitiesRepository(activitiesDataStoreService);
});

final activitiesListStreamProvider =
    StreamProvider.autoDispose.family<List<Activity?>, Trip>((ref, trip) {
  final activitiesRepository = ref.watch(activitiesRepositoryProvider);
  return activitiesRepository.getActivitiesForTrip(trip.id);
});

class ActivitiesRepository {
  ActivitiesRepository(
    this.activitiesDataStoreService,
  );

  final ActivitiesDataStoreService activitiesDataStoreService;

  Stream<List<Activity>> getActivitiesForTrip(String tripId) {
    return activitiesDataStoreService.listenToActivitiesForTrip(tripId);
  }

  Stream<Activity> listenToActivity(String id) {
    return activitiesDataStoreService.listenToActivity(id);
  }

  Future<Activity> getActivity(String id) {
    return activitiesDataStoreService.getActivity(id);
  }

  Future<void> add(Activity activity) async {
    await activitiesDataStoreService.addActivity(activity);
  }

  Future<void> update(Activity updatedActivity) async {
    await activitiesDataStoreService.updateActivity(updatedActivity);
  }

  Future<void> delete(Activity activity) async {
    await activitiesDataStoreService.deleteActivity(activity);
  }
}
