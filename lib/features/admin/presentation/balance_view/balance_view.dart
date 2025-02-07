import 'package:account_management/core/functions/navigation.dart';
import 'package:account_management/core/services/log_out_helper.dart';
import 'package:account_management/core/utils/colors.dart';
import 'package:account_management/core/utils/text_style.dart';
import 'package:account_management/core/widgets/custom_button.dart';
import 'package:account_management/core/widgets/image_stack.dart';
import 'package:account_management/features/admin/presentation/add_balance/add_balance_view.dart';
import 'package:account_management/features/admin/presentation/add_user/add_user.dart';
import 'package:account_management/features/admin/presentation/review/review_view.dart';
import 'package:account_management/features/admin/presentation/spend_amount/spend_amount_view.dart';
import 'package:account_management/features/admin/presentation/widget/balance_field.dart';
import 'package:account_management/features/user/data/user_repo/user_repo.dart';
import 'package:account_management/features/user/data/view_model/profile_res_model/profile_res_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class BalanceView extends StatefulWidget {
  const BalanceView({super.key});

  @override
  State<BalanceView> createState() => _BalanceViewState();
}

class _BalanceViewState extends State<BalanceView> {
  bool isLoading = true;
  int? expenses;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    UserRepo userRepo = UserRepo();
    Data? profileData = await userRepo.profileData();

    debugPrint(
        '📡 البيانات المستلمة: ${profileData.toString()}'); // ✅ طباعة كاملة للبيانات

    if (profileData != null) {
      debugPrint('🔹 المصاريف قبل التحديث: ${profileData.expenses}');

      setState(() {
        expenses = profileData.expenses; // حفظ القيمة في المتغير
        isLoading = false;
      });

      debugPrint('🔹 المصاريف بعد التحديث: $expenses');
    } else {
      debugPrint('🔹 لم يتم العثور على بيانات الملف الشخصي.');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.whiteColor,
          leading: IconButton(
              onPressed: () => LogOutHelper.logout(context),
              icon: const Icon(Icons.logout)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(30),
          child: Center(
            child: Stack(
              children: [
                ImageStack(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    isLoading
                        ? Center(child: CircularProgressIndicator())
                        : expenses != null
                            ? BalanceField(balance: expenses!) // عرض القيمة
                            : Text(
                                'لم يتم العثور على بيانات المصاريف 😔',
                                style: getBodyTextStyle(),
                              ),
                    Gap(25),
                    CustomButton(
                      text: 'إضافة رصيد ',
                      textColor: AppColors.whiteColor,
                      onPressed: () {
                        pushReplacement(context, AddBalanceView());
                      },
                      color: AppColors.primaryColor,
                    ),
                    Gap(25),
                    CustomButton(
                      text: ' صرف مبلغ ',
                      textColor: AppColors.whiteColor,
                      onPressed: () {
                        pushReplacement(context, SpendAmountView());
                      },
                      color: AppColors.primaryColor,
                    ),
                    Gap(25),
                    CustomButton(
                      text: ' مراجعة المستفيدين ',
                      textColor: AppColors.whiteColor,
                      onPressed: () {
                        pushReplacement(context, ReviewView());
                      },
                      color: AppColors.primaryColor,
                    ),
                    Gap(25),
                    CustomButton(
                      text: 'إضافة مستفيد ',
                      textColor: AppColors.whiteColor,
                      onPressed: () {
                        pushReplacement(context, AddUserView());
                      },
                      color: AppColors.primaryColor,
                    ),
                    Gap(25),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
