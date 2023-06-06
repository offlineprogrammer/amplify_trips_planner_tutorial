import 'package:amplify_trips_planner/features/profile/data/profile_repository.dart';
import 'package:amplify_trips_planner/models/ModelProvider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_controller.g.dart';

@riverpod
class ProfileController extends _$ProfileController {
  Future<Profile> _fetchProfile() async {
    final profileRepository = ref.read(profileRepositoryProvider);
    return profileRepository.getProfile();
  }

  @override
  FutureOr<Profile> build() async {
    return _fetchProfile();
  }

  Future<void> updateProfile(Profile profile) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final profileRepository = ref.read(profileRepositoryProvider);
      await profileRepository.update(profile);
      return _fetchProfile();
    });
  }
}
