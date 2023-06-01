import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_trips_planner/models/ModelProvider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileAPIServiceProvider = Provider<ProfileAPIService>((ref) {
  return ProfileAPIService();
});

class ProfileAPIService {
  ProfileAPIService();

  Future<Profile> getProfile() async {
    try {
      final request = ModelQueries.list(Profile.classType);
      final response = await Amplify.API.query(request: request).response;

      final profile = response.data!.items.first;

      return profile!;
    } on Exception catch (error) {
      safePrint('getProfile failed: $error');
      rethrow;
    }
  }

  Future<void> updateProfile(Profile updatedProfile) async {
    try {
      await Amplify.API
          .mutate(
            request: ModelMutations.update(updatedProfile),
          )
          .response;
    } on Exception catch (error) {
      safePrint('updateProfile failed: $error');
    }
  }
}
