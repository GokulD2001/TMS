import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
    employeeList = res.docs
        .where((doc) => doc.id != currentUserId)
        .map((doc) => {
              "id": doc.id,
              "name": doc['name'],
            })
        .toList();
    update(); 
  }Future<void> submitTask(String assignedBy, BuildContext context) async {
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
}