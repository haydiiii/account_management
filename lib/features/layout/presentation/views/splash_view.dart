import 'package:account_management/core/constatnts/image_assets.dart';
import 'package:account_management/core/functions/navigation.dart';
import 'package:account_management/core/services/local_storage.dart';
import 'package:account_management/features/admin/presentation/balance_view/balance_view.dart';
import 'package:account_management/features/layout/presentation/views/welcome_view.dart';
import 'package:account_management/features/user/presentation/balance_view/user_balance_view.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () async {
      String token =
          AppLocalStorage.getCachData(key: AppLocalStorage.token) ?? '';

      if (token.isNotEmpty) {
        String role =
            AppLocalStorage.getCachData(key: AppLocalStorage.role) ?? '';
        if (role == 'admin') {
          pushReplacement(context, BalanceView());
        } else {
          pushReplacement(context, UserBalanceView());
        }
      } else {
        pushReplacement(context, WelcomeView());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Image.asset(ImageAssets.logo)],
        ),
      ),
    );
  }
}
