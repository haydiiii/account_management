import 'package:account_management/core/functions/navigation.dart';
import 'package:account_management/core/utils/colors.dart';
import 'package:account_management/core/widgets/custom_button.dart';
import 'package:account_management/core/widgets/image_stack.dart';
import 'package:account_management/features/admin/presentation/add_balance/add_balance_view.dart';
import 'package:account_management/features/admin/presentation/review/review_view.dart';
import 'package:account_management/features/admin/presentation/spend_amount/spend_amount_view.dart';
import 'package:account_management/features/admin/presentation/widget/balance_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class BalanceView extends StatefulWidget {
  const BalanceView({super.key});

  @override
  State<BalanceView> createState() => _BalanceViewState();
}

class _BalanceViewState extends State<BalanceView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                      balance:1,
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
                      onPressed: () {},
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
