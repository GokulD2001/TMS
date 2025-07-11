import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/all_pages_text_strings/dashboard_text.dart';
import '../../screens/assigned_tasks_screen.dart';
import '../../screens/task_form_screen.dart';
import '../../controllers/dashboard_controller.dart';

class CommonDrawer extends StatelessWidget {
  final String userId;
  final String userName;

  const CommonDrawer({
    super.key,
    required this.userId,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DashboardController>();

    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(userName),
            accountEmail:  Text(userId), 
            currentAccountPicture: const CircleAvatar(
              child: Icon(Icons.person),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.add_task),
            title: const Text(DashboardText.assignTask),
            onTap: () {
              Navigator.pop(context);
              Get.to(() => TaskFormScreen(
                    currentUserId: userId,
                    assignedBy: userId,
                  ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.task),
            title: const Text(DashboardText.viewMyTasks),
            onTap: () {
              Navigator.pop(context);
              Get.to(() => AssignedTasksScreen(userId: userId));
            },
          ),
          const Spacer(),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text(DashboardText.logoutTooltip),
            onTap: () => controller.logout(context),
          ),
        ],
      ),
    );
  }
}
