import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/login_screen.dart';

class DashboardController extends GetxController {
  var userId = '';
  var userName = '';

  void setUser({required String id, required String name}) {
    userId = id;
    userName = name;
  }
Future<void> checkNotifications(String userId) async {
  final snapshot = await FirebaseFirestore.instance
      .collection('notifications')
      .where('userId', isEqualTo: userId)
      .where('isRead', isEqualTo: false)
      .get();

  if (snapshot.docs.isNotEmpty) {
    for (var doc in snapshot.docs) { 
      Get.snackbar(
        "New Task Assigned",
        doc['message'],
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.blue.shade100,
        margin: const EdgeInsets.all(12),
        borderRadius: 8,
        duration: const Duration(seconds: 3),
      );
      await doc.reference.update({'isRead': true});
    }
  }
}

  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_id');
    await prefs.remove('user_name');

    Get.offAll(() =>  LoginScreen());
  }
}