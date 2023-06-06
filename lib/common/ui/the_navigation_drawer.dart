import 'package:amplify_trips_planner/common/navigation/router/routes.dart';
import 'package:amplify_trips_planner/common/services/auth_service.dart';
import 'package:amplify_trips_planner/common/utils/colors.dart' as constants;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class TheNavigationDrawer extends ConsumerWidget {
  const TheNavigationDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color(constants.primaryColorDark),
            ),
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                SizedBox(height: 10),
                Text(
                  'Amplify Trips Planner',
                  style: TextStyle(fontSize: 22, color: Colors.white),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Trips'),
            onTap: () {
              context.goNamed(
                AppRoute.home.name,
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.category),
            title: const Text('Past Trips'),
            onTap: () {
              context.goNamed(
                AppRoute.pastTrips.name,
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              context.goNamed(
                AppRoute.profile.name,
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Logout'),
            onTap: () => ref.read(authServiceProvider).signOut(),
          ),
        ],
      ),
    );
  }
}
