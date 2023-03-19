import 'package:amplify_trips_planner/common/navigation/router/routes.dart';
import 'package:amplify_trips_planner/features/trip/ui/edit_trip_page/edit_trip_page.dart';
import 'package:amplify_trips_planner/features/trip/ui/trip_page/trip_page.dart';
import 'package:amplify_trips_planner/features/trip/ui/trips_list/trips_list_page.dart';
import 'package:amplify_trips_planner/models/ModelProvider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:amplify_trips_planner/features/trip/ui/past_trips/past_trips_list.dart';
import 'package:amplify_trips_planner/features/trip/ui/past_trip_page/past_trip_page.dart';
import 'package:amplify_trips_planner/features/activity/ui/add_activity/add_activity_page.dart';
import 'package:amplify_trips_planner/features/activity/ui/activity_page/activity_page.dart';
import 'package:amplify_trips_planner/features/activity/ui/edit_activity/edit_activity_page.dart';
import 'package:amplify_trips_planner/features/profile/ui/profile_page/profile_page.dart';

final router = GoRouter(
  routes: [
    GoRoute(
        path: '/',
        name: AppRoute.home.name,
        builder: (context, state) => const TripsListPage()),
    GoRoute(
      path: '/trip/:id',
      name: AppRoute.trip.name,
      builder: (context, state) {
        final tripId = state.params['id']!;
        return TripPage(tripId: tripId);
      },
    ),
    GoRoute(
      path: '/edittrip/:id',
      name: AppRoute.edittrip.name,
      builder: (context, state) {
        return EditTripPage(
          trip: state.extra! as Trip,
        );
      },
    ),
    GoRoute(
      path: '/pasttrips',
      name: AppRoute.pasttrips.name,
      builder: (context, state) => const PastTripsList(),
    ),
    GoRoute(
      path: '/pasttrip/:id',
      name: AppRoute.pasttrip.name,
      builder: (context, state) {
        final tripId = state.params['id']!;
        return PastTripPage(tripId: tripId);
      },
    ),
    GoRoute(
      path: '/addActivity/:id',
      name: AppRoute.addactivity.name,
      builder: (context, state) {
        final tripId = state.params['id']!;
        return AddActivityPage(tripId: tripId);
      },
    ),
    GoRoute(
      path: '/activity/:id',
      name: AppRoute.activity.name,
      builder: (context, state) {
        final activityId = state.params['id']!;
        return ActivityPage(activityId: activityId);
      },
    ),
    GoRoute(
      path: '/editactivity/:id',
      name: AppRoute.editactivity.name,
      builder: (context, state) {
        return EditActivityPage(
          activity: state.extra! as Activity,
        );
      },
    ),
    GoRoute(
      path: '/profile',
      name: AppRoute.profile.name,
      builder: (context, state) => const ProfilePage(),
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text(state.error.toString()),
    ),
  ),
);
