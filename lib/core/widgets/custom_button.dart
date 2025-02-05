import 'package:account_management/core/constatnts/size_config.dart';
import 'package:account_management/core/utils/text_style.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double? width;
  final double? height;
  final String text;
  final Color? color;
  final Color? textColor;
  final Function() onPressed;
  final OutlinedBorder? shape;

  const CustomButton({
    super.key,
    this.width,
    this.height,
    required this.text,
    this.color,
    this.textColor,
    required this.onPressed,
    this.shape,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.blockWidth * 40, // 50% of screen width
      height: SizeConfig.blockHeight * 7,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: shape ??
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  5,
                ), // شكل افتراضي بزوايا دائرية
              ),
          backgroundColor: color,
        ),
        child: Center(
          child: Text(
            textAlign: TextAlign.center,
            text,
            style: getBodyTextStyle(
              color: textColor,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
