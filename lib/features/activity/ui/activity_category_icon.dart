import 'package:flutter/material.dart';
import 'package:amplify_trips_planner/models/ModelProvider.dart';
import 'package:amplify_trips_planner/common/utils/colors.dart' as constants;

class ActivityCategoryIcon extends StatelessWidget {
  const ActivityCategoryIcon({
    required this.activityCategory,
    super.key,
  });
  final ActivityCategory activityCategory;

  @override
  Widget build(BuildContext context) {
    switch (activityCategory) {
      case ActivityCategory.Flight:
        return const Icon(
          Icons.flight,
          size: 50,
          color: Color(constants.primaryColorDark),
        );

      case ActivityCategory.Lodging:
        return const Icon(
          Icons.hotel,
          size: 50,
          color: Color(constants.primaryColorDark),
        );
      case ActivityCategory.Meeting:
        return const Icon(
          Icons.computer,
          size: 50,
          color: Color(constants.primaryColorDark),
        );
      case ActivityCategory.Restaurant:
        return const Icon(
          Icons.restaurant,
          size: 50,
          color: Color(constants.primaryColorDark),
        );
      default:
        ActivityCategory.Flight;
    }
    return const Icon(
      Icons.flight,
      size: 50,
      color: Color(constants.primaryColorDark),
    );
  }
}
