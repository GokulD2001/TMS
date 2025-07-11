import 'package:cloud_firestore/cloud_firestore.dart';

class AssignedTaskModel {
  final String taskName;
  final String taskDesc;
  final DateTime? startDate;
  final DateTime? endDate;
  final String assignedBy;

  AssignedTaskModel({
    required this.taskName,
    required this.taskDesc,
    required this.startDate,
    required this.endDate,
    required this.assignedBy,
  });

  factory AssignedTaskModel.fromMap(Map<String, dynamic> data) {
    return AssignedTaskModel(
      taskName: data['task_name'] ?? '',
      taskDesc: data['task_desc'] ?? '',
      startDate: (data['task_start_date_and_time'] as Timestamp?)?.toDate(),
      endDate: (data['task_end_date_and_time'] as Timestamp?)?.toDate(),
      assignedBy: data['assigned_by'] ?? '',
    );
  }
}
