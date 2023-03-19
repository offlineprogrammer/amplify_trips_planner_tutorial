import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

class AuthService {
  AuthService();

  Future<String?> getUserEmail() async {
    try {
      final result = await Amplify.Auth.fetchUserAttributes();
      for (final element in result) {
        if (element.userAttributeKey.toString() == 'email') {
          return element.value;
        }
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
    return null;
  }

  Future<void> signOut() async {
    try {
      await Amplify.Auth.signOut();
      await Amplify.DataStore.clear();
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }
}
