import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_trips_planner/models/ModelProvider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileDataStoreServiceProvider =
    Provider<ProfileDatastoreService>((ref) {
  return ProfileDatastoreService();
});

class ProfileDatastoreService {
  ProfileDatastoreService();

  Stream<Profile> listenToProfile() {
    return Amplify.DataStore.observeQuery(
      Profile.classType,
    ).map((event) => event.items.first).handleError(
      (dynamic error) {
        debugPrint('listenToProfile: A Stream error happened');
      },
    );
  }

  Future<void> updateProfile(Profile updatedProfile) async {
    try {
      final profileWithId = await Amplify.DataStore.query(
        Profile.classType,
        where: Profile.ID.eq(updatedProfile.id),
      );

      final oldProfile = profileWithId.first;
      final newProfile = oldProfile.copyWith(
          firstName: updatedProfile.firstName,
          lastName: updatedProfile.lastName,
          homeCity: updatedProfile.homeCity);

      await Amplify.DataStore.save(newProfile);
    } on Exception catch (error) {
      debugPrint(error.toString());
    }
  }

  Future<void> addProfile(Profile profile) async {
    try {
      await Amplify.DataStore.save(profile);
    } on Exception catch (error) {
      debugPrint(error.toString());
    }
  }
}
