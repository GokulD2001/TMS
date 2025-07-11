import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/keyboard_types.dart';
import '../../constants/app_colors.dart';
import '../../constants/text_styles.dart';

class CommonTextFormField extends TextFormField {
  final String text;
  final RegExp inputformat;
  final int limitLength;
  final String star;
  final TextInputType inputtype;
  final TextStyle? textStyle;

  final bool showEye; 
  final VoidCallback? onEyeTap;

  @override
  final bool enabled;
  final int minLines;
  @override
  final TextEditingController? controller;
  final bool alignLabelWithHint;
  final bool obscureText;
  final int maxLines;
  @override
  final String? Function(String?)? validator;
  @override
  final Function(String?) onSaved;
  @override
  final String? initialValue;
  @override
  final Function(String?)? onChanged;
  final Widget? suffixIcon;
  final bool autoValidate;
  final FocusNode? focusNode;
  final InputDecoration? decoration;

  CommonTextFormField({
    super.key,
    required this.text,
    required this.inputformat,
    required this.limitLength,
    required this.onSaved,
    this.star = "*",
    this.inputtype = keyboardTypeText,
    this.textStyle,
    this.enabled = true,
    this.minLines = 1,
    this.maxLines = 1,
    this.controller,
    this.obscureText = false,
    this.onChanged,
    this.validator,
    this.initialValue = "",
    this.suffixIcon,
    this.autoValidate = false,
    this.focusNode,
    this.decoration,
    this.alignLabelWithHint = false,
    this.showEye = false, 
    this.onEyeTap,
  }) : super(
          controller: controller,
          maxLines: maxLines,
          minLines: minLines,
          focusNode: focusNode ?? FocusNode(),
          initialValue: controller == null ? initialValue : null,
          inputFormatters: [
            FilteringTextInputFormatter.allow(inputformat),
            LengthLimitingTextInputFormatter(limitLength),
          ],
          keyboardType: inputtype,
          cursorColor: AppColors.black,
          obscureText: obscureText,
          autovalidateMode: autoValidate
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          decoration: (decoration ?? const InputDecoration()).copyWith(
            alignLabelWithHint: alignLabelWithHint,
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.grey),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.grey),
            ),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.secondary),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.secondary),
            ),
            border: const OutlineInputBorder(),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 15.0,
            ),
            label: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: text,
                    style: textStyle ?? textStyleGrey18,
                  ),
                  TextSpan(
                    text: star,
                    style: textStyleMandotary,
                  ),
                ],
              ),
            ),
            errorStyle: const TextStyle(color: AppColors.secondary),
            suffixIcon: showEye
                ? IconButton(
                    icon: Icon(
                      obscureText ? Icons.visibility_off : Icons.visibility,
                      color: AppColors.grey,
                    ),
                    onPressed: onEyeTap,
                  )
                : suffixIcon,
          ),
          validator: validator,
          enabled: enabled,
          style: textStyleBlack16,
          onSaved: onSaved,
          onChanged: onChanged,
        );
}
