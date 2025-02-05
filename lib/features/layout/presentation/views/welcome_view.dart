import 'package:account_management/core/constatnts/image_assets.dart';
import 'package:account_management/core/functions/navigation.dart';
import 'package:account_management/core/utils/colors.dart';
import 'package:account_management/core/utils/text_style.dart';
import 'package:account_management/features/login/presentation/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            /////
            Opacity(
              opacity: 0.7,
              child: Image.asset(
                ImageAssets.logo,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.contain,
              ),
            ),
            ///////////////
            Positioned(
              top: 50,
              right: 25,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('أهلا بيك ', style: getHeadlineTextStyle(context)),
                ],
              ),
            ),
            Positioned(
              bottom: 50,
              left: 25,
              right: 25,
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withAlpha(100),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.greyColor.withAlpha(128),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      'سجل دلوقتي كــ',
                      style: getBodyTextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Gap(25),
                    GestureDetector(
                      onTap: () {
                        pushReplacement(context, const LoginView());
                      },
                      child: Container(
                        margin: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                          bottom: 15,
                        ),
                        height: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppColors.whiteColor.withAlpha(128),
                        ),
                        child: Center(
                          child: Text(
                            'أدمن',
                            style: getBodyTextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        pushReplacement(context, const LoginView());
                      },
                      child: Container(
                        margin: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                          bottom: 15,
                        ),
                        height: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppColors.whiteColor.withAlpha(10),
                        ),
                        child: Center(
                          child: Text(
                            'مستخدم',
                            style: getBodyTextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
