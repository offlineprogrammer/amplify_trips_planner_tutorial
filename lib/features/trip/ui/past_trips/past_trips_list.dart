import 'package:amplify_trips_planner/common/ui/the_navigation_drawer.dart';
import 'package:amplify_trips_planner/common/utils/colors.dart' as constants;
import 'package:amplify_trips_planner/features/trip/controller/past_trips_list.dart';
import 'package:amplify_trips_planner/features/trip/ui/trips_gridview/trips_list_gridview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PastTripsList extends ConsumerWidget {
  const PastTripsList({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tripsListValue = ref.watch(pastTripsListProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Amplify Trips Planner',
        ),
        backgroundColor: const Color(constants.primaryColorDark),
      ),
      drawer: const TheNavigationDrawer(),
      body: TripsListGridView(
        tripsList: tripsListValue,
        isPast: true,
      ),
    );
  }
}
