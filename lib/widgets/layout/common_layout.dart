import 'package:flutter/material.dart';
import 'package:task_management/constants/app_colors.dart';
import '../appbar/appbar.dart';
import '../drawer/common_drawer.dart';

class CommonLayoutDrawer extends StatelessWidget {
  final Widget body;
  final String appBarTitle;
  final String? userId;
  final String? userName;
  final bool hasDrawer;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final List<Widget>? persistentFooterButtons;

  const CommonLayoutDrawer({
    super.key,
    required this.body,
    required this.appBarTitle,
    this.userId,
    this.userName,
    this.hasDrawer = true,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.persistentFooterButtons,
  }) : assert(
          hasDrawer == false || (userId != null && userName != null),
          "userId and userName are required when drawer is enabled.",
        );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: BuildAppBar(title: appBarTitle),
      drawer: hasDrawer
          ? CommonDrawer(
              userId: userId!,
              userName: userName!,
            )
          : null,
      body: body,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      persistentFooterButtons: persistentFooterButtons,
    );
  }
}
