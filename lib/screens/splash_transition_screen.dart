import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dashboard_screen.dart';

class SplashTransitionScreen extends StatefulWidget {
  final String userId;
  final String userName;

  const SplashTransitionScreen({
    super.key,
    required this.userId,
    required this.userName,
  });

  @override
  State<SplashTransitionScreen> createState() => _SplashTransitionScreenState();
}

class _SplashTransitionScreenState extends State<SplashTransitionScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAll(() => DashboardScreen(
            userId: widget.userId,
            userName: widget.userName,
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(), 
      ),
    );
  }
}
