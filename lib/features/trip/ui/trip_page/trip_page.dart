// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';

// import 'package:amplify_trips_planner/common/navigation/router/routes.dart';
// import 'package:amplify_trips_planner/features/trip/data/trips_repository.dart';
// import 'package:amplify_trips_planner/common/utils/colors.dart' as constants;
// import 'package:amplify_trips_planner/features/trip/ui/trip_page/selected_trip_card.dart';
// import 'package:amplify_trips_planner/features/activity/ui/activities_list/activities_list.dart';
// import 'package:amplify_trips_planner/common/ui/the_navigation_drawer.dart';

// class TripPage extends ConsumerWidget {
//   const TripPage({
//     required this.tripId,
//     super.key,
//   });
//   final String tripId;

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final tripValue = ref.watch(tripProvider(tripId));
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text(
//           'Amplify Trips Planner',
//         ),
//         actions: [
//           IconButton(
//             onPressed: () {
//               context.goNamed(
//                 AppRoute.home.name,
//               );
//             },
//             icon: const Icon(Icons.home),
//           ),
//         ],
//         backgroundColor: const Color(constants.primaryColorDark),
//       ),
//       drawer: const TheNavigationDrawer(),
//       floatingActionButton: tripValue.when(
//         data: (trip) => FloatingActionButton(
//           onPressed: () {
//             context.goNamed(
//               AppRoute.addactivity.name,
//               params: {'id': tripId},
//             );
//           },
//           backgroundColor: const Color(constants.primaryColorDark),
//           child: const Icon(Icons.add),
//         ),
//         error: (e, st) => const Placeholder(),
//         loading: () => const Placeholder(),
//       ),
//       body: tripValue.when(
//         data: (trip) => trip == null
//             ? const Center(
//                 child: Text('Trip Not Found'),
//               )
//             : Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   const SizedBox(
//                     height: 8,
//                   ),
//                   SelectedTripCard(trip: trip),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   const Divider(
//                     height: 20,
//                     thickness: 5,
//                     indent: 20,
//                     endIndent: 20,
//                   ),
//                   const Text(
//                     'Your Activities',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 8,
//                   ),
//                   Expanded(
//                     child: ActivitiesList(
//                       trip: trip,
//                     ),
//                   )
//                 ],
//               ),
//         error: (e, st) => Center(
//           child: Column(
//             children: [
//               Text(e.toString()),
//               TextButton(
//                   onPressed: () async => ref.refresh(tripProvider(tripId)),
//                   child: const Text('Try again')),
//             ],
//           ),
//         ),
//         loading: () => const Center(
//           child: CircularProgressIndicator(),
//         ),
//       ),
//     );
//   }
// }
