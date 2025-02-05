import 'package:account_management/core/functions/navigation.dart';
import 'package:account_management/core/utils/colors.dart';
import 'package:account_management/core/utils/text_style.dart';
import 'package:account_management/core/widgets/custom_button.dart';
import 'package:account_management/core/widgets/image_stack.dart';
import 'package:account_management/features/admin/presentation/balance_view/balance_view.dart';
import 'package:account_management/features/admin/presentation/spend_amount/widget/covenant_view.dart';
import 'package:account_management/features/admin/presentation/spend_amount/widget/expenses_view.dart';
import 'package:account_management/features/admin/presentation/widget/balance_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SpendAmountView extends StatefulWidget {
  const SpendAmountView({super.key});

  @override
  State<SpendAmountView> createState() => _SpendAmountViewState();
}

class _SpendAmountViewState extends State<SpendAmountView> {
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
                    BalanceField(
                      balance: 1,
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
