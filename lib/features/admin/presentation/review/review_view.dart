import 'package:account_management/core/functions/navigation.dart';
import 'package:account_management/core/utils/colors.dart';
import 'package:account_management/core/utils/text_style.dart';
import 'package:account_management/core/widgets/custom_button.dart';
import 'package:account_management/core/widgets/image_stack.dart';
import 'package:account_management/features/admin/presentation/balance_view/balance_view.dart';
import 'package:account_management/features/admin/presentation/review/widgets/covenant_review_view.dart';
import 'package:account_management/features/admin/presentation/review/widgets/expenses_review_view.dart';
import 'package:account_management/features/admin/presentation/widget/balance_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ReviewView extends StatefulWidget {
  const ReviewView({super.key});

  @override
  State<ReviewView> createState() => _ReviewViewState();
}

class _ReviewViewState extends State<ReviewView> {
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
                    BalanceField(
                      balance: 1,
                    ),
                    Gap(25),
                    CustomButton(
                      text: 'عهدة',
                      textColor: AppColors.whiteColor,
                      onPressed: () {
                        pushReplacement(context, CovenantReviewView());
                      },
                      color: AppColors.primaryColor,
                    ),
                    Gap(25),
                    CustomButton(
                      text: ' مصروفات ',
                      textColor: AppColors.whiteColor,
                      onPressed: () {
                        pushReplacement(context, ExpensesReviewView());
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
