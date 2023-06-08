import 'package:amplify_trips_planner/common/navigation/router/routes.dart';
import 'package:amplify_trips_planner/common/utils/colors.dart' as constants;
import 'package:amplify_trips_planner/features/trip/ui/trips_gridview/trip_gridview_item_card.dart';
import 'package:amplify_trips_planner/models/ModelProvider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TripGridViewItem extends StatelessWidget {
  const TripGridViewItem({
    required this.trip,
    required this.isPast,
    super.key,
  });

  final Trip trip;
  final bool isPast;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      onTap: () {
        context.goNamed(
          isPast ? AppRoute.pastTrip.name : AppRoute.trip.name,
          pathParameters: {'id': trip.id},
          extra: trip,
        );
      },
      child: isPast
          ? ColorFiltered(
              colorFilter: const ColorFilter.matrix(constants.greyoutMatrix),
              child: TripGridViewItemCard(
                trip: trip,
              ),
            )
          : TripGridViewItemCard(
              trip: trip,
            ),
    );
  }
}
