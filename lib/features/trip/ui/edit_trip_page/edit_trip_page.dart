import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_trips_planner/common/navigation/router/routes.dart';
import 'package:amplify_trips_planner/features/trip/controller/trip_controller.dart';
import 'package:amplify_trips_planner/models/ModelProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:amplify_trips_planner/common/utils/colors.dart' as constants;

class EditTripPage extends HookConsumerWidget {
  EditTripPage({
    required this.trip,
    super.key,
  });
  final Trip trip;

  final formGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tripNameController = useTextEditingController(text: trip.tripName);
    final destinationController =
        useTextEditingController(text: trip.destination);
    final startDateController = useTextEditingController(
        text: DateFormat('yyyy-MM-dd').format(trip.startDate.getDateTime()));
    final endDateController = useTextEditingController(
        text: DateFormat('yyyy-MM-dd').format(trip.endDate.getDateTime()));

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Amplify Trips Planner',
        ),
        leading: IconButton(
          onPressed: () {
            context.goNamed(
              AppRoute.trip.name,
              params: {'id': trip.id},
            );
          },
          icon: const Icon(Icons.arrow_back),
        ),
        backgroundColor: const Color(constants.primaryColorDark),
      ),
      body: SingleChildScrollView(
        child: Form(
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
                  //initialValue: trip.tripName,
                  controller: tripNameController,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    const validationError = 'Enter a valid trip name';
                    if (value == null || value.isEmpty) {
                      return validationError;
                    }

                    return null;
                  },
                  autofocus: true,
                  autocorrect: false,
                  decoration: const InputDecoration(hintText: "Trip Name"),
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  //initialValue: trip.destination,
                  keyboardType: TextInputType.name,
                  controller: destinationController,
                  autofocus: true,
                  autocorrect: false,
                  decoration:
                      const InputDecoration(hintText: "Trip Destination"),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value != null && value.isNotEmpty) {
                      return null;
                    } else {
                      return 'Enter a valid destination';
                    }
                  },
                ),
                TextFormField(
                  // initialValue: trip.startDate.toString(),
                  keyboardType: TextInputType.datetime,
                  controller: startDateController,
                  autofocus: true,
                  autocorrect: false,
                  decoration: const InputDecoration(hintText: "Start Date"),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value != null && value.isNotEmpty) {
                      return null;
                    } else {
                      return 'Enter a valid date';
                    }
                  },
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
                TextFormField(
                  //  initialValue: trip.endDate.toString(),
                  keyboardType: TextInputType.datetime,
                  controller: endDateController,
                  autofocus: true,
                  autocorrect: false,
                  decoration: const InputDecoration(hintText: "End Date"),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value != null && value.isNotEmpty) {
                      return null;
                    } else {
                      return 'Enter a valid date';
                    }
                  },
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
                        final updatedTrip = trip.copyWith(
                          tripName: tripNameController.text,
                          destination: destinationController.text,
                          startDate: TemporalDate(
                              DateTime.parse(startDateController.text)),
                          endDate: TemporalDate(
                              DateTime.parse(endDateController.text)),
                        );
                        ref.read(tripControllerProvider).edit(updatedTrip);
                        context.goNamed(
                          AppRoute.trip.name,
                          params: {'id': trip.id},
                        );
                      }
                    } //,
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
