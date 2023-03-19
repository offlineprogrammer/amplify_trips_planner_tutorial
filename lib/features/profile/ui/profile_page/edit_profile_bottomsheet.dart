import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:amplify_trips_planner/features/profile/controller/profile_controller.dart';
import 'package:amplify_trips_planner/models/ModelProvider.dart';

class EditProfileBottomSheet extends ConsumerWidget {
  EditProfileBottomSheet({
    required this.profile,
    super.key,
  });

  final Profile profile;

  final formGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firstNameController = TextEditingController(
        text: profile.firstName != null ? profile.firstName! : '');
    final lastNameController = TextEditingController(
        text: profile.lastName != null ? profile.lastName! : '');
    final homeCityController = TextEditingController(
        text: profile.homeCity != null ? profile.homeCity! : '');

    return Form(
      key: formGlobalKey,
      child: Container(
        padding: EdgeInsets.only(
            top: 15,
            left: 15,
            right: 15,
            bottom: MediaQuery.of(context).viewInsets.bottom + 15),
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: firstNameController,
              keyboardType: TextInputType.name,
              validator: (value) {
                const validationError = 'Enter a valid name';
                if (value == null || value.isEmpty) {
                  return validationError;
                }

                return null;
              },
              autofocus: true,
              autocorrect: false,
              decoration: const InputDecoration(hintText: "First Name"),
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              keyboardType: TextInputType.name,
              controller: lastNameController,
              autofocus: true,
              autocorrect: false,
              decoration: const InputDecoration(hintText: "Last Name"),
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value != null && value.isNotEmpty) {
                  return null;
                } else {
                  return 'Enter a valid name';
                }
              },
            ),
            TextFormField(
              keyboardType: TextInputType.name,
              controller: homeCityController,
              autofocus: true,
              autocorrect: false,
              decoration: const InputDecoration(hintText: "Home City"),
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value != null && value.isNotEmpty) {
                  return null;
                } else {
                  return 'Enter a valid city';
                }
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
                child: const Text('OK'),
                onPressed: () async {
                  final currentState = formGlobalKey.currentState;
                  if (currentState == null) {
                    return;
                  }
                  if (currentState.validate()) {
                    final updatedProfile = profile.copyWith(
                      firstName: firstNameController.text,
                      lastName: lastNameController.text,
                      homeCity: homeCityController.text,
                    );
                    ref.read(profileControllerProvider).edit(updatedProfile);
                    Navigator.of(context).pop();
                  }
                } //,
                ),
          ],
        ),
      ),
    );
  }
}
