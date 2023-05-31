import 'package:amplify_trips_planner/features/profile/services/profile_api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:amplify_trips_planner/models/ModelProvider.dart';

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  ProfileAPIService profileAPIService = ref.read(profileAPIServiceProvider);
  return ProfileRepository(profileAPIService);
});

class ProfileRepository {
  ProfileRepository(this.profileAPIService);
  final ProfileAPIService profileAPIService;

  Future<Profile> getProfile() {
    return profileAPIService.getProfile();
  }

  Future<void> update(Profile updatedProfile) async {
    await profileAPIService.updateProfile(updatedProfile);
  }
}
