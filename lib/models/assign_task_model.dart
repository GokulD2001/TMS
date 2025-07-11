
 import 'package:cloud_firestore/cloud_firestore.dart';

class AssignTaskModel {
  final String taskId;
  final String taskName;
  final String taskDesc;
  final String assignedTo;
  final String assignedBy;
  final DateTime startDateTime;
  final DateTime endDateTime;

  AssignTaskModel({
    required this.taskId,
    required this.taskName,
    required this.taskDesc,
    required this.assignedTo,
    required this.assignedBy,
    required this.startDateTime,
    required this.endDateTime,
  });
  Map<String, dynamic> toJson() {
    return {
      'task_id': taskId,
      'task_name': taskName,
      'task_desc': taskDesc,
      'assigned_to': assignedTo,
      'assigned_by': assignedBy,
      'task_start_date_and_time': Timestamp.fromDate(startDateTime),
      'task_end_date_and_time': Timestamp.fromDate(endDateTime),
    };
  }
  factory AssignTaskModel.fromJson(Map<String, dynamic> json) {
    return AssignTaskModel(
      taskId: json['task_id'],
      taskName: json['task_name'],
      taskDesc: json['task_desc'],
      assignedTo: json['assigned_to'],
      assignedBy: json['assigned_by'],
      startDateTime: (json['task_start_date_and_time'] as Timestamp).toDate(),
      endDateTime: (json['task_end_date_and_time'] as Timestamp).toDate(),
    );
  }
}
