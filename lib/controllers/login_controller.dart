import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/login_model.dart';
import '../screens/splash_transition_screen.dart';
class LoginController extends GetxController {
  final name = ''.obs;
  final password = ''.obs;
  final obscurePassword = true.obs;
  final message = RxnString();
  final isLoading = false.obs; 

  final formKey = GlobalKey<FormState>();

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  Future<void> loginOrSignup() async {
    isLoading.value = true; 

    try {
      final userName = name.value.trim();
      final pass = password.value.trim();

      final users = await FirebaseFirestore.instance
          .collection('employees')
          .where('name', isEqualTo: userName)
          .get();

      if (users.docs.isNotEmpty) {
        final user = UserModel.fromJson(users.docs.first.data());

        if (user.password == pass) {
          await _saveLogin(user.id, user.name);
          await _saveFcmToken(user.id);

          Get.snackbar("Login Success", "Welcome, $userName",
              backgroundColor: Colors.green.shade100,
              snackPosition: SnackPosition.TOP,
              duration: const Duration(seconds: 2));

          Get.to(() => SplashTransitionScreen(
                userId: user.id,
                userName: user.name,
              ));
        } else {
          Get.snackbar("Login Failed", " Incorrect password",
              backgroundColor: Colors.red.shade100,
              snackPosition: SnackPosition.BOTTOM);
        }
      } else {
        final newId = DateTime.now().millisecondsSinceEpoch.toString();
        final newUser = UserModel(id: newId, name: userName, password: pass);

        await FirebaseFirestore.instance
            .collection('employees')
            .doc(newId)
            .set(newUser.toJson());

        await _saveLogin(newId, userName);
        await _saveFcmToken(newId);

        Get.snackbar("Registration Success", "Welcome, $userName",
            backgroundColor: Colors.green.shade100,
            snackPosition: SnackPosition.TOP,
            duration: const Duration(seconds: 2));

        Get.to(() => SplashTransitionScreen(
              userId: newId,
              userName: userName,
            ));
      }
    } catch (e) {
      print("$e");
      Get.snackbar("Error", "Something went wrong: $e",
          backgroundColor: Colors.red.shade100,
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _saveLogin(String userId, String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_id', userId);
    await prefs.setString('user_name', name);
  }

  Future<void> _saveFcmToken(String userId) async {
    final token = await FirebaseMessaging.instance.getToken();
    if (token != null) {
      await FirebaseFirestore.instance
          .collection('employees')
          .doc(userId)
          .update({'fcm_token': token});
    }
  }
}
