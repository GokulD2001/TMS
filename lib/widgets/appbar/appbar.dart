import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

class BuildAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool centerTitle;

  const BuildAppBar({
    Key? key,
    required this.title,
    this.actions,
    this.centerTitle = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor:AppColors .white,
      surfaceTintColor: AppColors .white,
      centerTitle: centerTitle,
      title: Text(
        title,
       
      ),
      actions: actions,
      iconTheme: const IconThemeData(color: AppColors .black,),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
