import 'package:account_management/core/constatnts/size_config.dart';
import 'package:account_management/core/utils/colors.dart';
import 'package:account_management/core/utils/text_style.dart';
import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  final String label;

  const TitleWidget({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: SizeConfig.screenHeight * 0.08,
      width: SizeConfig.screenWidth * 0.5,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        label,
        style: getBodyTextStyle(
            fontSize: SizeConfig.blockWidth * 5, color: AppColors.accentColor),
        textAlign: TextAlign.center,
      ),
    );
  }
}
