import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_trips_planner/common/ui/bottomsheet_text_form_field.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:intl/intl.dart';
import 'package:amplify_trips_planner/common/navigation/router/routes.dart';
import 'package:amplify_trips_planner/features/activity/controller/activity_controller.dart';

import 'package:amplify_trips_planner/common/utils/colors.dart' as constants;
import 'package:amplify_trips_planner/models/ModelProvider.dart';

class EditActivityPage extends ConsumerWidget {
  EditActivityPage({
    required this.activity,
    super.key,
  });

  final Activity activity;

  final formGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activityNameController =
        TextEditingController(text: activity.activityName);
    final activityDateController = TextEditingController(
        text: DateFormat('yyyy-MM-dd')
            .format(activity.activityDate.getDateTime()));

    var activityTime =
        TimeOfDay.fromDateTime(activity.activityTime!.getDateTime());
    final activityTimeController = TextEditingController(
        text:
            DateFormat('hh:mm a').format(activity.activityTime!.getDateTime()));

    final activityCategoryController =
        TextEditingController(text: activity.category.name);

    var activityCategory = activity.category;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Amplify Trips Planner',
        ),
        leading: IconButton(
          onPressed: () {
            context.goNamed(
              AppRoute.activity.name,
              pathParameters: {'id': activity.id},
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
                BottomSheetTextFormField(
                  labelText: 'Activity Name',
                  controller: activityNameController,
                  keyboardType: TextInputType.name,
                ),
                const SizedBox(
                  height: 20,
                ),
                DropdownButtonFormField<ActivityCategory>(
                  onChanged: (value) {
                    activityCategoryController.text = value!.name;
                    activityCategory = value;
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
                BottomSheetTextFormField(
                  labelText: 'Activity Date',
                  controller: activityDateController,
                  keyboardType: TextInputType.datetime,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate:
                          DateTime.parse(activity.activityDate.toString()),
                      firstDate:
                          DateTime.parse(activity.trip.startDate.toString()),
                      lastDate:
                          DateTime.parse(activity.trip.endDate.toString()),
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
                BottomSheetTextFormField(
                  labelText: 'Activity Time',
                  controller: activityTimeController,
                  keyboardType: TextInputType.datetime,
                  onTap: () async {
                    await showTimePicker(
                      context: context,
                      initialTime: activityTime,
                      initialEntryMode: TimePickerEntryMode.dial,
                    ).then((timeOfDay) {
                      if (timeOfDay != null) {
                        final localizations = MaterialLocalizations.of(context);
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
                        final format = DateFormat.jm();

                        activityTime = TimeOfDay.fromDateTime(
                            format.parse(activityTimeController.text));

                        final now = DateTime.now();
                        final time = DateTime(now.year, now.month, now.day,
                            activityTime.hour, activityTime.minute);

                        final updatedActivity = activity.copyWith(
                            category: ActivityCategory.values
                                .byName(activityCategoryController.text),
                            activityName: activityNameController.text,
                            activityDate: TemporalDate(
                                DateTime.parse(activityDateController.text)),
                            activityTime: TemporalTime.fromString(
                                DateFormat("HH:mm:ss.sss").format(time)));

                        ref
                            .watch(activityControllerProvider(activity.id)
                                .notifier)
                            .updateActivity(updatedActivity);

                        context.goNamed(
                          AppRoute.activity.name,
                          pathParameters: {'id': activity.id},
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
