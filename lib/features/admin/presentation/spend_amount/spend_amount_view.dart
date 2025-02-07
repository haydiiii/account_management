import 'package:account_management/core/functions/navigation.dart';
import 'package:account_management/core/utils/colors.dart';
import 'package:account_management/core/utils/text_style.dart';
import 'package:account_management/core/widgets/custom_button.dart';
import 'package:account_management/core/widgets/image_stack.dart';
import 'package:account_management/features/admin/presentation/balance_view/balance_view.dart';
import 'package:account_management/features/admin/presentation/spend_amount/widget/covenant_view.dart';
import 'package:account_management/features/admin/presentation/spend_amount/widget/expenses_view.dart';
import 'package:account_management/features/admin/presentation/widget/balance_field.dart';
import 'package:account_management/features/user/data/user_repo/user_repo.dart';
import 'package:account_management/features/user/data/view_model/profile_res_model/profile_res_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SpendAmountView extends StatefulWidget {
  const SpendAmountView({super.key});

  @override
  State<SpendAmountView> createState() => _SpendAmountViewState();
}

class _SpendAmountViewState extends State<SpendAmountView> {
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
          title: Text(
            'صرف مبلغ',
            style: getHeadlineTextStyle(context, color: Colors.white),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () {
              pushReplacement(context, BalanceView());
            },
          ),
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
                      text: 'عهدة',
                      textColor: AppColors.whiteColor,
                      onPressed: () {
                        pushReplacement(context, CovenantView());
                      },
                      color: AppColors.primaryColor,
                    ),
                    Gap(25),
                    CustomButton(
                      text: ' مصروفات ',
                      textColor: AppColors.whiteColor,
                      onPressed: () {
                        pushReplacement(context, ExpensesView());
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
