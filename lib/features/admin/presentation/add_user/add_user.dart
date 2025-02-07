import 'package:account_management/core/functions/dialogs.dart';
import 'package:account_management/core/functions/navigation.dart';
import 'package:account_management/core/utils/colors.dart';
import 'package:account_management/core/utils/text_style.dart';
import 'package:account_management/core/widgets/custom_button.dart';
import 'package:account_management/core/widgets/image_stack.dart';
import 'package:account_management/features/admin/presentation/add_user/add_user_repo.dart';
import 'package:account_management/features/admin/presentation/balance_view/balance_view.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AddUserView extends StatefulWidget {
  const AddUserView({super.key});

  @override
  State<AddUserView> createState() => _AddUserViewState();
}

class _AddUserViewState extends State<AddUserView> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>(); // 🔹 مفتاح للتحقق من صحة الإدخال

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'إضافة مستفيد',
            style: getHeadlineTextStyle(context, color: Colors.white),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () {
              pushReplacement(context, const BalanceView());
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(30),
          child: Center(
            child: Stack(
              children: [
                ImageStack(),
                SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Gap(50),

                        // 🔹 اسم المستخدم
                        Text('الاسم', style: getTitleTextStyle(context)),
                        const Gap(10),
                        TextFormField(
                          controller: nameController,
                          decoration: InputDecoration(
                            hintText: 'أدخل اسم المستخدم',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '⚠️ يرجى إدخال الاسم';
                            }
                            return null;
                          },
                        ),
                        const Gap(30),

                        // 🔹 البريد الإلكتروني
                        Text('البريد الإلكتروني',
                            style: getTitleTextStyle(context)),
                        const Gap(10),
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: 'أدخل البريد الإلكتروني',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '⚠️ يرجى إدخال البريد الإلكتروني';
                            }
                            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                .hasMatch(value)) {
                              return '⚠️ يرجى إدخال بريد إلكتروني صحيح';
                            }
                            return null;
                          },
                        ),
                        const Gap(30),

                        Text('رقم الهاتف', style: getTitleTextStyle(context)),
                        const Gap(10),
                        TextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            hintText: 'أدخل رقم الهاتف (اختياري)',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          // تغيير التحقق ليكون اختياريًا
                          validator: (value) {
                            if (value != null && value.isNotEmpty) {
                              if (!RegExp(r'^[0-9]{10,15}$').hasMatch(value)) {
                                return '⚠️ يرجى إدخال رقم هاتف صالح (10-15 أرقام)';
                              }
                            }
                            return null;
                          },
                        ),

                        const Gap(30),

                        // 🔹 كلمة المرور
                        Text('كلمة المرور', style: getTitleTextStyle(context)),
                        const Gap(10),
                        TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'أدخل كلمة المرور',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '⚠️ يرجى إدخال كلمة المرور';
                            }
                            if (value.length < 6) {
                              return '⚠️ يجب أن تحتوي كلمة المرور على 6 أحرف على الأقل';
                            }
                            return null;
                          },
                        ),
                        const Gap(50),

                        // 🔹 زر الإضافة
                        Center(
                          child: CustomButton(
                            onPressed: () async {
                              if (_formKey.currentState?.validate() ?? false) {
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) => Center(
                                    child: CircularProgressIndicator(
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                );
                                try {
                                  await AddUserRepo().addUser(
                                    nameController.text,
                                    emailController.text,
                                    phoneController.text,
                                    passwordController.text,
                                  );
                                  Navigator.pop(context);
                                  showSuccessDialog(
                                    context,
                                    'تم حفظ البيانات بنجاح!',
                                  );
                                } catch (error) {
                                  Navigator.pop(context);

                                  showErrorDialog(context, 'حدث خطأ: $error');
                                }
                              }
                            },
                            text: 'حفظ',
                            textColor: AppColors.whiteColor,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
