import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management/controllers/user_controller.dart';
import 'package:task_management/screens/dashboard_screen.dart';
import 'package:task_management/screens/login_screen.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Background message received: ${message.messageId}");
}

Future<void> initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDGAXUAqYtEHIqWvnyRRo-VblFma60_-dk",
      authDomain: "taskmanagement-a9ad6.firebaseapp.com",
      projectId: "taskmanagement-a9ad6",
      storageBucket: "taskmanagement-a9ad6.firebasestorage.app",
      messagingSenderId: "64476021204",
      appId: "1:64476021204:web:aa45a2efd3794c45ead641",
      measurementId: "G-GZFV7TD2VR",
    ),
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await FirebaseMessaging.instance.requestPermission();

  final prefs = await SharedPreferences.getInstance();
  final userController = Get.put(UserController());
  final userId = prefs.getString('user_id');
  final userName = prefs.getString('user_name');

  if (userId != null && userName != null) {
    userController.setUser(userId, userName);
  }
}

void main() async {
  await initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.find<UserController>();

    return Obx(() => GetMaterialApp(
          title: 'Task Management App',
          debugShowCheckedModeBanner: false,
          home: userController.isLoggedIn.value
              ? DashboardScreen(
                  userId: userController.userId.value,
                  userName: userController.userName.value,
                )
              :  LoginScreen(),
        ));
  }
}
