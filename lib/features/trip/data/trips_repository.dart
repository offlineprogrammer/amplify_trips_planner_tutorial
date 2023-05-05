import 'package:amplify_trips_planner/features/trip/services/trips_api_service.dart';

import 'package:amplify_trips_planner/models/Trip.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final tripsRepositoryProvider = Provider<TripsRepository>((ref) {
  TripsAPIService tripsAPIService = ref.read(tripsAPIServiceProvider);
  return TripsRepository(tripsAPIService);
});

// final tripProvider =
//     StreamProvider.autoDispose.family<Trip?, String>((ref, id) {
//   final tripsRepository = ref.watch(tripsRepositoryProvider);
//   return tripsRepository.get(id);
// });

class TripsRepository {
  TripsRepository(this.tripsAPIService);

  final TripsAPIService tripsAPIService;

  Future<List<Trip>> getTrips() {
    return tripsAPIService.getTrips();
  }

  Future<void> add(Trip trip) async {
    await tripsAPIService.addTrip(trip);
  }

  Future<void> update(Trip updatedTrip) async {
    await tripsAPIService.updateTrip(updatedTrip);
  }

  Future<void> delete(Trip deletedTrip) async {
    await tripsAPIService.deleteTrip(deletedTrip);
  }

  Future<Trip> getTrip(String tripId) async {
    return await tripsAPIService.getTrip(tripId);
  }
}
