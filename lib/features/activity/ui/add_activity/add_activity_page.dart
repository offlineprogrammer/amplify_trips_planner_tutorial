import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:amplify_trips_planner/common/navigation/router/routes.dart';
import 'package:amplify_trips_planner/features/activity/controller/activities_list_controller.dart';
import 'package:amplify_trips_planner/features/trip/data/trips_repository.dart';
import 'package:amplify_trips_planner/models/ModelProvider.dart';
import 'package:amplify_trips_planner/common/utils/colors.dart' as constants;

class AddActivityPage extends ConsumerWidget {
  AddActivityPage({
    required this.tripId,
    super.key,
  });

  final String tripId;

  final formGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tripValue = ref.read(tripProvider(tripId));
    final activityNameController = TextEditingController();
    final activityDateController = TextEditingController();
    final activityTimeController = TextEditingController();
    var activityCategory = ActivityCategory.Flight;
    var activityTime = TimeOfDay.now();

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
              params: {'id': tripId},
            );
          },
          icon: const Icon(Icons.arrow_back),
        ),
        backgroundColor: const Color(constants.primaryColorDark),
      ),
      body: tripValue.when(
        data: (trip) => SingleChildScrollView(
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
                    controller: activityNameController,
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      const validationError = 'Enter a valid activity name';
                      if (value == null || value.isEmpty) {
                        return validationError;
                      }

                      return null;
                    },
                    autofocus: true,
                    autocorrect: false,
                    decoration:
                        const InputDecoration(hintText: "Activity Name"),
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField<ActivityCategory>(
                    onChanged: (value) {
                      activityCategory = value!;
                    },
                    value: activityCategory,
                    decoration: const InputDecoration(
                      labelText: 'Category',
                    ),
                    items: [
                      for (var category in ActivityCategory.values)
                        DropdownMenuItem(
                          value: category,
                          child: Text(category.name),
                        ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.datetime,
                    controller: activityDateController,
                    autofocus: true,
                    autocorrect: false,
                    decoration:
                        const InputDecoration(hintText: "Activity Date"),
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
                        initialDate: DateTime.parse(trip!.startDate.toString()),
                        firstDate: DateTime.parse(trip.startDate.toString()),
                        lastDate: DateTime.parse(trip.endDate.toString()),
                      );

                      if (pickedDate != null) {
                        String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                        activityDateController.text = formattedDate;
                      } else {}
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: activityTimeController,
                    decoration:
                        const InputDecoration(hintText: "Activity Time"),
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        return null;
                      } else {
                        return 'Enter a valid date';
                      }
                    },
                    onTap: () async {
                      await showTimePicker(
                        context: context,
                        initialTime: activityTime,
                        initialEntryMode: TimePickerEntryMode.dial,
                      ).then((timeOfDay) {
                        if (timeOfDay != null) {
                          final localizations =
                              MaterialLocalizations.of(context);
                          final formattedTimeOfDay =
                              localizations.formatTimeOfDay(timeOfDay);

                          activityTimeController.text = formattedTimeOfDay;
                          activityTime = timeOfDay;
                        }
                      });
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
                          ref.read(activitiesListController(trip!)).add(
                                name: activityNameController.text,
                                activityDate: activityDateController.text,
                                activityTime: activityTime,
                                category: activityCategory,
                                trip: trip,
                              );
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
        error: (e, st) => const Center(
          child: Text('Error'),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
