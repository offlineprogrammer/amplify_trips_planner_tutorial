import 'package:amplify_trips_planner/features/trip/ui/past_trip_page/selected_past_trip_card.dart';
import 'package:amplify_trips_planner/models/ModelProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PastTripDetails extends ConsumerWidget {
  const PastTripDetails({
    required this.trip,
    super.key,
  });

  final AsyncValue<Trip> trip;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    switch (trip) {
      case AsyncData(:final value):
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 8,
            ),
            SelectedPastTripCard(trip: value),
            const SizedBox(
              height: 20,
            ),
            const Divider(
              height: 20,
              thickness: 5,
              indent: 20,
              endIndent: 20,
            ),
            const Text(
              'Your Activities',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
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
