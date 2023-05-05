import 'dart:async';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_trips_planner/features/trip/data/trips_repository.dart';
import 'package:amplify_trips_planner/models/ModelProvider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'async_past_trips_list.g.dart';

@riverpod
class AsyncPastTrips extends _$AsyncPastTrips {
  Future<List<Trip>> _fetchTrips() async {
    final tripsRepository = ref.read(tripsRepositoryProvider);
    final trips = await tripsRepository.getPastTrips();
    return trips;
  }

  @override
  FutureOr<List<Trip>> build() async {
    return _fetchTrips();
  }
}
