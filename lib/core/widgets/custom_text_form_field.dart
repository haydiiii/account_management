import 'package:account_management/core/utils/colors.dart';
import 'package:account_management/core/utils/text_style.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?) validator;
  final bool? isVisible;
  final VoidCallback? toggleVisibility;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.validator,
    this.isVisible,
    this.toggleVisibility,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: isVisible ?? false,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: getSmallTextStyle(context, color: AppColors.greyColor),
        suffixIcon: toggleVisibility != null
            ? IconButton(
                icon: Icon(
                  isVisible!
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: AppColors.greyColor,
                ),
                onPressed: toggleVisibility,
              )
            : null,
      ),
    );
  }
}
