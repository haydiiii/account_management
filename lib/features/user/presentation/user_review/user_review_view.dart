import 'package:account_management/core/functions/navigation.dart';
import 'package:account_management/core/utils/colors.dart';
import 'package:account_management/core/utils/text_style.dart';
import 'package:account_management/core/widgets/custom_button.dart';
import 'package:account_management/core/widgets/image_stack.dart';
import 'package:account_management/features/admin/presentation/widget/balance_field.dart';
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
                    BalanceField(
                      balance: 0,
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
