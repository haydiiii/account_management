import 'package:account_management/core/functions/navigation.dart';
import 'package:account_management/features/layout/presentation/views/welcome_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogOutHelper {
  static Future<void> logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    Future.microtask(() {
      pushReplacement(context, WelcomeView());
    });
  }
}
