import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_management/widgets/Buttons/primary_button.dart';
import 'package:task_management/widgets/date_time_picker/date_time_picker.dart';
import 'package:task_management/widgets/drop_downs/single_select_drop_down.dart';
import 'package:task_management/widgets/layout/common_layout.dart';
import 'package:task_management/widgets/text_form_field/common_text_form_field.dart';
import 'package:task_management/constants/regex_patterns.dart';

import '../constants/all_pages_text_strings/dashboard_text.dart';
import '../constants/all_pages_text_strings/login_text_strings.dart';
import '../constants/all_pages_text_strings/task_page_text.dart';
import '../constants/commom_gaps/commom_gaps.dart';
import '../controllers/assign_task_controller.dart';
import '../widgets/sized_box/sized_box.dart';
class TaskFormScreen extends StatelessWidget {
  final String assignedBy;
  final String currentUserId;

  const TaskFormScreen({
    super.key,
    required this.assignedBy,
    required this.currentUserId,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TaskFormController>(
      init: TaskFormController()..loadEmployees(currentUserId),
      builder: (controller) {
        return CommonLayoutDrawer(
         appBarTitle: DashboardText.assignTask,
         hasDrawer: false,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      CommonSizedBox(
                        child: CommonTextFormField(
                          text: TaskFormLabels.taskDescription,
                          star: star,
                          inputtype: TextInputType.text,
                          validator: (val) =>
                              val == null || val.isEmpty ? "Enter task name" : null,
                          onSaved: (val) => controller.taskName = val,
                          inputformat: alphabetsSpace,
                          limitLength: 50,
                        ),
                      ),
                 CommonGaps.vertical16,
                      CommonSizedBox(
                        child: CommonTextFormField(
                        text: TaskFormLabels.taskDescription,
                          star: star,
                          inputtype: TextInputType.multiline,
                          alignLabelWithHint: true,
                          
                          maxLines: 5,
                          minLines: 5,
                          validator: (val) => val == null || val.isEmpty
                              ? "Enter description"
                              : null,
                          onSaved: (val) => controller.taskDesc = val,
                          inputformat: alphabetsAndNumbers,
                          limitLength: 120,
                        ),
                      ),
                     CommonGaps.vertical16,
                   CommonSizedBox(
                     child: SingleSelectDropDownMVC(
                       selectedId: controller.selectedEmployeeId,
                       dropdownItems: controller.employeeList,
                       dropDownName: TaskFormLabels.assignToEmployee,
                       optionalisEmpty: true,
                       star: star,
                       onChanged: (val) => controller.selectedEmployeeId = val,
                       onSaved: (val) => controller.selectedEmployeeId = val,
                     ),
                   ),
                CommonGaps.vertical16,
                CommonSizedBox(
                  child: DateTimeTextFormFieldMVC(
                    text: TaskFormLabels.startDateTime,
                    star: star,
                    enabled: true,
                    validator: (val) =>
                        val == null || val.isEmpty ? 'Please select start date & time' : null,
                    onSaved: (val) {
                      if (val != null && val.isNotEmpty) {
                        controller.startDate =
                DateFormat('dd-MMM-yyyy hh:mm a').parse(val);
                      }
                    },
                  ),
                ),
                CommonGaps.vertical16,
                CommonSizedBox(
                  child: DateTimeTextFormFieldMVC(
                    text: TaskFormLabels.endDateTime,
                    star: star,
                    enabled: true,
                    validator: (val) =>
                        val == null || val.isEmpty ? 'Please select end date & time' : null,
                    onSaved: (val) {
                      if (val != null && val.isNotEmpty) {
                        controller.endDate =
                DateFormat('dd-MMM-yyyy hh:mm a').parse(val);
                      }
                    },
                  ),
                ),
                
                     CommonGaps.vertical20,
                      PrimaryButton(
                       text: TaskFormLabels.submitButton,
                        onPressed: () =>
                            controller.submitTask(assignedBy, context),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
