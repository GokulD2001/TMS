import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/text_styles.dart';


class PrimaryButton extends ElevatedButton {
  PrimaryButton(
      {super.key,
      required String text,
      required onPressed,
      color = AppColors.primaryButtonColor,
      bool isEnabled = true})
      : super(
          onPressed: isEnabled ? onPressed : null,
          child: Text(text, style: textStyleWhite16),
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          ),
        );
}
