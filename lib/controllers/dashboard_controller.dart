import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/login_screen.dart';

class DashboardController extends GetxController {
  var userId = '';
  var userName = '';

  void setUser({required String id, required String name}) {
    userId = id;
    userName = name;
  }

  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_id');
    await prefs.remove('user_name');

    Get.offAll(() =>  LoginScreen());
  }
}
