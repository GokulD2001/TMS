import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/all_pages_text_strings/dashboard_text.dart';
import '../constants/commom_gaps/commom_gaps.dart';
import '../controllers/dashboard_controller.dart';
import '../widgets/Buttons/primary_button.dart';
import '../widgets/layout/common_layout.dart';
import 'assigned_tasks_screen.dart';
import 'task_form_screen.dart';

class DashboardScreen extends StatelessWidget {
  final String userId;
  final String userName;

  DashboardScreen({
    super.key,
    required this.userId,
    required this.userName,
  }) {
    final controller = Get.put(DashboardController());
    controller.setUser(id: userId, name: userName);
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DashboardController>();

    return CommonLayoutDrawer(
      appBarTitle: DashboardText.dashboardTitle,
      userId: controller.userId,
      userName: controller.userName,
      body: Stack(
        children: [
          Positioned(
            top: 20,
            right: 20,
            child: Row(
              children: [
                PrimaryButton(
                  text: DashboardText.assignTask,
                  onPressed: () {
                    Get.to(() => TaskFormScreen(
                          currentUserId: controller.userId,
                          assignedBy: controller.userId,
                        ));
                  },
                ),
                CommonGaps.horizontal10,
                PrimaryButton(
                  text: DashboardText.viewMyTasks,
                  onPressed: () {
                    Get.to(() =>
                        AssignedTasksScreen(userId: controller.userId));
                  },
                ),
              ],
            ),
          ),

          Center(
            child: Text(
              "${DashboardText.welcome}, ${controller.userName}!",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
