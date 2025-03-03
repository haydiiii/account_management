import 'package:account_management/core/utils/colors.dart';
import 'package:flutter/material.dart';

TextStyle getHeadlineTextStyle(
  context, {
  double fontSize = 30,
  fontWeight = FontWeight.normal,
  Color? color,
}) {
  return TextStyle(
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color ?? AppColors.textTitleColor,
  );
}

// title

TextStyle getTitleTextStyle(
  context, {
  double fontSize = 24,
  fontWeight = FontWeight.normal,
  Color? color,
}) {
  return TextStyle(
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color ?? Theme.of(context).colorScheme.onSurface,
  );
}

TextStyle getBodyTextStyle({
  double? fontSize = 18,
  fontWeight = FontWeight.normal,
  Color? color,
}) {
  return TextStyle(
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color ?? AppColors.secondaryColor,
  );
}
// small

TextStyle getSmallTextStyle(
  context, {
  double fontSize = 16,
  fontWeight = FontWeight.normal,
  Color? color,
}) {
  return TextStyle(
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color ?? Theme.of(context).colorScheme.onSurface,
  );
}
