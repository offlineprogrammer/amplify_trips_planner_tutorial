import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:amplify_trips_planner/common/services/storage_service.dart';

import 'package:amplify_trips_planner/models/Trip.dart';
import 'package:amplify_trips_planner/features/trip/data/trips_repository.dart';

final tripControllerProvider = Provider<TripController>((ref) {
  return TripController(ref);
});

class TripController {
  TripController(this.ref);
  final Ref ref;

  Future<void> edit(Trip updatedTrip) async {
    final tripsRepository = ref.read(tripsRepositoryProvider);
    await tripsRepository.update(updatedTrip);
  }

  Future<void> delete(Trip deletedTrip) async {
    final tripsRepository = ref.read(tripsRepositoryProvider);
    await tripsRepository.delete(deletedTrip);
  }
}
