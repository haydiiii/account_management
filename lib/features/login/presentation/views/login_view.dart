import 'package:account_management/core/constatnts/image_assets.dart';
import 'package:account_management/core/constatnts/size_config.dart';
import 'package:account_management/core/functions/dialogs.dart';
import 'package:account_management/core/utils/colors.dart';
import 'package:account_management/core/widgets/custom_button.dart';
import 'package:account_management/core/widgets/custom_text_form_field.dart';
import 'package:account_management/features/admin/presentation/balance_view/balance_view.dart';
import 'package:account_management/features/layout/presentation/views/welcome_view.dart';
import 'package:account_management/features/login/data/repo/login_repo.dart';
import 'package:account_management/features/user/presentation/balance_view/user_balance_view.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/functions/navigation.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var passwordController = TextEditingController();
  bool isPasswordVisible = false;

  void togglePasswordVisibility() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.whiteColor,
          automaticallyImplyLeading: false,
          centerTitle: false,
          title: IconButton(
            onPressed: () {
              pushReplacement(context, WelcomeView());
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
                padding: const EdgeInsets.all(15),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: ClipRRect(
                          child: Image.asset(
                            ImageAssets.logo,
                            height: SizeConfig.blockHeight * 30,
                          ),
                        ),
                      ),
                      Gap(50),
                      CustomTextField(
                        controller: nameController,
                        hintText: 'إسم المستخدم',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'من فضلك أدخل إسمك';
                          } else {
                            return null;
                          }
                        },
                      ),
                      Gap(25),
                      CustomTextField(
                        controller: passwordController,
                        hintText: 'أدخل كلمة المرور',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'من فضلك أدخل كلمة المرور';
                          } else {
                            return null;
                          }
                        },
                        isVisible: isPasswordVisible,
                        toggleVisibility: togglePasswordVisibility,
                      ),
                      Gap(25),
                      Center(
                        child: CustomButton(
                          color: AppColors.primaryColor,
                          textColor: AppColors.whiteColor,
                          text: 'تسجيل الدخول',
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              showLoadingDialog(context);
                              try {
                                Map<String, dynamic> response =
                                    await LoginRepo.login(
                                  nameController.text,
                                  passwordController.text,
                                );
                                bool loginSuccess =
                                    response['success'] ?? false;

                                if (loginSuccess) {
                                  pop(context);
                                  showSuccessDialog(
                                      context, 'تم تسجيل الدخول بنجاح');
                                  String role = response['data']['role'] ?? '';
                                  if (role == 'admin') {
                                    pushReplacement(context, BalanceView());
                                  } else {
                                    pushReplacement(context, UserBalanceView());
                                  }
                                  debugPrint(
                                      'تم تسجيل الدخول بنجاح: $response');
                                } else {
                                  pop(context);
                                  showErrorDialog(
                                      context, 'البيانات غير صحيحة');
                                  debugPrint('البيانات غير صحيحة: $response');
                                }
                              } catch (error) {
                                Navigator.pop(context);
                                debugPrint('حدث خطأ: $error');
                                showErrorDialog(context, 'حدث خطأ');
                              }
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ))));
  }
}
