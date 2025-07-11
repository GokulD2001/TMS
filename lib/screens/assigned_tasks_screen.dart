import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_management/constants/commom_gaps/commom_gaps.dart';
import 'package:task_management/constants/text_styles.dart';
import 'package:task_management/widgets/layout/common_layout.dart';

import '../constants/all_pages_text_strings/assigned_text.dart';
import '../constants/all_pages_text_strings/dashboard_text.dart';
import '../controllers/assigned_tasks_controller.dart';

class AssignedTasksScreen extends StatelessWidget {
  final String userId;
  const AssignedTasksScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    final AssignedTaskController controller =
        Get.put(AssignedTaskController(userId: userId));

    return CommonLayoutDrawer(
      appBarTitle: DashboardText.viewMyTasks,
      hasDrawer: false,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.error.isNotEmpty) {
          return Center(
            child: Text(
              "${AssignedTasksText.loadingErrorPrefix}${controller.error}",
              textAlign: TextAlign.center,
            ),
          );
        }

        if (controller.tasks.isEmpty) {
          return const Center(
            child: Text(AssignedTasksText.noTasksMessage),
          );
        }

        return ListView.builder(
          itemCount: controller.tasks.length,
          itemBuilder: (context, index) {
            final task = controller.tasks[index];

            return FutureBuilder<String>(
              future: controller.getUserName(task.assignedBy),
              builder: (context, userSnapshot) {
                final assignedByName = userSnapshot.data ?? 'Loading...';

                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(
                      task.taskName,
                      style: textStyleBlack18,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         CommonGaps.vertical10,
                        Text(task.taskDesc,style: textStyleBlack16,),
                        CommonGaps.vertical10,
                        if (task.startDate != null && task.endDate != null)
                      Text(
  "Start Date: ${DateFormat.yMMMd().add_jm().format(task.startDate!)}\n"
  "End Date:   ${DateFormat.yMMMd().add_jm().format(task.endDate!)}",
  style: const TextStyle(color: Colors.grey),
)
                        else
                          const Text(AssignedTasksText.invalidDateMessage),
                        const SizedBox(height: 4),
                        Text("${AssignedTasksText.assignedByPrefix}$assignedByName"),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      }),
    );
  }
}
