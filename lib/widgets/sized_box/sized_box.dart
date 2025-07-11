import 'package:flutter/material.dart';

import '../../constants/height_width/height_width.dart';

// ignore: must_be_immutable
class CommonSizedBox extends StatelessWidget {
  CommonSizedBox(
      {super.key, required this.child, this.width = primaryWidth, this.height});
  final Widget child;
  final double width;
  var height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: child,
    );
  }
}
