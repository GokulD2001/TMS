import 'dart:convert';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../constants/all_pages_text_strings/task_page_text.dart';
import '../models/assign_task_model.dart';

class TaskFormController extends GetxController {
  final formKey = GlobalKey<FormState>();

  String? taskName;
  String? taskDesc;
  String? selectedEmployeeId;
  DateTime? startDate;
  DateTime? endDate;

  List<Map<String, dynamic>> employeeList = [];

  Future<void> loadEmployees(String currentUserId) async {
    final res = await FirebaseFirestore.instance.collection('employees').get();
    employeeList =
        res.docs
            .where((doc) => doc.id != currentUserId)
            .map((doc) => {"id": doc.id, "name": doc['name']})
            .toList();
    update();
  }

  Future<void> submitTask(String assignedBy, BuildContext context) async {
    if (!formKey.currentState!.validate()) return;
    formKey.currentState!.save();

    if (selectedEmployeeId == null || startDate == null || endDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please complete all fields")),
      );
      return;
    }

    final taskId = DateTime.now().millisecondsSinceEpoch.toString();

    final task = AssignTaskModel(
      taskId: taskId,
      taskName: taskName!,
      taskDesc: taskDesc!,
      assignedTo: selectedEmployeeId!,
      assignedBy: assignedBy,
      startDateTime: startDate!,
      endDateTime: endDate!,
    );

    await FirebaseFirestore.instance
        .collection('tasks')
        .doc(taskId)
        .set(task.toJson());
    await FirebaseFirestore.instance.collection('notifications').add({
      'userId': selectedEmployeeId,
      'message': "You have been assigned a new task: $taskName",
      'timestamp': FieldValue.serverTimestamp(),
      'isRead': false,
    });

    await _sendPushNotificationToUser(selectedEmployeeId!, taskName!);

    Get.back();
    Get.snackbar(
      TaskFormLabels.taskAssignedTitle,
      TaskFormLabels.taskAssignedMessage,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.shade100,
      margin: const EdgeInsets.all(12),
      borderRadius: 8,
      duration: const Duration(seconds: 2),
    );
  }

  Future<void> _sendPushNotificationToUser(
    String userId,
    String taskName,
  ) async {
    final userDoc =
        await FirebaseFirestore.instance
            .collection('employees')
            .doc(userId)
            .get();
    final fcmToken = userDoc['fcm_token'];
    if (fcmToken != null) {
      final serverKey =
          'BBYAHI0svkD7zuTnyUMYt_vxgBNrW424_KQXedq5sGlEH0Bdl-fc9SzlWbh1EbnATcs3jz2U-zWMqPYhbiqZgHc'; 

      final message = {
        'notification': {
          'title': 'New Task Assigned',
          'body': 'You have been assigned a new task: $taskName',
        },
        'priority': 'high',
        'to': fcmToken,
      };

      final response = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'key=$serverKey',
        },
        body: jsonEncode(message),
      );

      if (response.statusCode == 200) {
        print("Push notification sent.");
      } else {
        print("Failed to send push notification: ${response.body}");
      }
    }
  }
}