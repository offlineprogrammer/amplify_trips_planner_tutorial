import 'package:amplify_trips_planner/features/trip/controller/trips_list.dart';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class AddTripBottomSheet extends ConsumerWidget {
  AddTripBottomSheet({
    super.key,
  });

  final formGlobalKey = GlobalKey<FormState>();

  static TextFormField createTextFormField({
    required String labelText,
    required TextEditingController controller,
    required TextInputType keyboardType,
    Function()? onTap,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      autofocus: true,
      autocorrect: false,
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a value';
        }

        return null;
      },
      decoration: InputDecoration(
        labelText: labelText,
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tripNameController = TextEditingController();
    final destinationController = TextEditingController();
    final startDateController = TextEditingController();
    final endDateController = TextEditingController();

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
            createTextFormField(
              labelText: 'Trip Name',
              controller: tripNameController,
              keyboardType: TextInputType.name,
            ),
            const SizedBox(
              height: 20,
            ),
            createTextFormField(
              labelText: 'Trip Destination',
              controller: destinationController,
              keyboardType: TextInputType.name,
            ),
            const SizedBox(
              height: 20,
            ),
            createTextFormField(
              labelText: 'Start Date',
              controller: startDateController,
              keyboardType: TextInputType.datetime,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101));

                if (pickedDate != null) {
                  String formattedDate =
                      DateFormat('yyyy-MM-dd').format(pickedDate);
                  startDateController.text = formattedDate;
                } else {}
              },
            ),
            const SizedBox(
              height: 20,
            ),
            createTextFormField(
              labelText: 'End Date',
              controller: endDateController,
              keyboardType: TextInputType.datetime,
              onTap: () async {
                if (startDateController.text.isNotEmpty) {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.parse(startDateController.text),
                      firstDate: DateTime.parse(startDateController.text),
                      lastDate: DateTime(2101));

                  if (pickedDate != null) {
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);

                    endDateController.text = formattedDate;
                  }
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
                    ref.watch(tripsListProvider.notifier).addTrip(
                          name: tripNameController.text,
                          destination: destinationController.text,
                          startDate: startDateController.text,
                          endDate: endDateController.text,
                        );
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
