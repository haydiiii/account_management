import 'package:account_management/core/functions/navigation.dart';
import 'package:account_management/core/utils/colors.dart';
import 'package:account_management/core/utils/text_style.dart';
import 'package:account_management/core/widgets/custom_button.dart';
import 'package:account_management/core/widgets/image_stack.dart';
import 'package:account_management/features/admin/presentation/widget/balance_field.dart';
import 'package:account_management/features/user/data/user_repo/user_repo.dart';
import 'package:account_management/features/user/data/view_model/profile_res_model/profile_res_model.dart';
import 'package:account_management/features/user/presentation/balance_view/user_balance_view.dart';
import 'package:account_management/features/user/presentation/user_review/widgets/user_covenant_review_view.dart';
import 'package:account_management/features/user/presentation/user_review/widgets/user_expenses_review_view.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class UserReviewView extends StatefulWidget {
  const UserReviewView({super.key});

  @override
  State<UserReviewView> createState() => _UserReviewViewState();
}

class _UserReviewViewState extends State<UserReviewView> {
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
    debugPrint(profileData?.expenses?.toString()); 

    if (profileData != null) {
      setState(() {
        expenses = profileData.expenses;
        isLoading = false;
      });
      debugPrint('🔹 قيمة الـ expenses: $expenses');
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
            'مراجعة ',
            style: getHeadlineTextStyle(context, color: Colors.white),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () {
              pushReplacement(context, UserBalanceView());
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
                        pushReplacement(context, UserCovenantReviewView());
                      },
                      color: AppColors.primaryColor,
                    ),
                    Gap(25),
                    CustomButton(
                      text: ' مصروفات ',
                      textColor: AppColors.whiteColor,
                      onPressed: () {
                        pushReplacement(context, UserExpensesReviewView());
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
