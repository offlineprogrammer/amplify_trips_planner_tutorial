import 'dart:async';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_trips_planner/models/Trip.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final tripsAPIServiceProvider = Provider<TripsAPIService>((ref) {
  final service = TripsAPIService();
  return service;
});

class TripsAPIService {
  TripsAPIService();

  Future<List<Trip>> getTrips() async {
    try {
      final request = ModelQueries.list(Trip.classType);
      final response = await Amplify.API.query(request: request).response;

      final todos = response.data?.items;
      if (todos == null) {
        safePrint('errors: ${response.errors}');
        return const [];
      }
      return todos.map((e) => e as Trip).toList();
    } on ApiException catch (e) {
      safePrint('Query failed: $e');
      return const [];
    }
  }

  // StreamSubscription<GraphQLResponse<Trip>>? subscription;

  // Stream<List<Trip?>> subscribe() {
  //   final subscriptionRequest = ModelSubscriptions.onCreate(Trip.classType);
  //   final Stream<GraphQLResponse<Trip>> operation = Amplify.API.subscribe(
  //     subscriptionRequest,
  //     onEstablished: () => safePrint('Subscription established'),
  //   );
  //   subscription = operation.listen(
  //     (event) {
  //       safePrint('Subscription event data received: ${event.data}');
  //     },
  //     onError: (Object e) => safePrint('Error in subscription stream: $e'),
  //   );

  //   return operation.map((event) => event.data).toList().asStream();
  // }

  // Stream<List<Trip?>> subscribe() {
  //   final subscriptionRequest = ModelSubscriptions.onCreate(Trip.classType);
  //   final operation = Amplify.API
  //       .subscribe(
  //         subscriptionRequest,
  //         onEstablished: () => safePrint('Subscription established'),
  //       )
  //       // Listens to only 5 elements
  //       .take(5)
  //       .map((event) => event.data)
  //       .toList()
  //       .asStream()
  //       .handleError(
  //     (Object error) {
  //       safePrint('Error in subscription stream: $error');
  //     },
  //   );

  //   subscription = operation.listen(
  //     (event) {
  //       safePrint('Subscription event data received: ${event.data}');
  //     },
  //   );
  //   return operation;
  // }

  Future<void> addTrip(Trip trip) async {
    try {
      final request = ModelMutations.create(trip);
      final response = await Amplify.API.mutate(request: request).response;

      final createdTrip = response.data;
      if (createdTrip == null) {
        safePrint('errors: ${response.errors}');
        return;
      }
      safePrint('Mutation result: ${createdTrip.tripName}');
    } on Exception catch (error) {
      debugPrint(error.toString());
    }
  }

  Future<void> deleteTrip(Trip trip) async {
    try {
      // await Amplify.DataStore.delete(trip);
    } on Exception catch (error) {
      debugPrint(error.toString());
    }
  }

  Future<void> updateTrip(Trip updatedTrip) async {
    try {
      // final tripsWithId = await Amplify.DataStore.query(
      //   Trip.classType,
      //   where: Trip.ID.eq(updatedTrip.id),
      // );

      // final oldTrip = tripsWithId.first;
      // final newTrip = oldTrip.copyWith(
      //   tripName: updatedTrip.tripName,
      //   destination: updatedTrip.destination,
      //   startDate: updatedTrip.startDate,
      //   endDate: updatedTrip.endDate,
      //   tripImageKey: updatedTrip.tripImageKey,
      //   tripImageUrl: updatedTrip.tripImageUrl,
      // );

      // await Amplify.DataStore.save(newTrip);
    } on Exception catch (error) {
      debugPrint(error.toString());
    }
  }
}
