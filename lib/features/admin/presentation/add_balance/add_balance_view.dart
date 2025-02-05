import 'package:account_management/core/functions/navigation.dart';
import 'package:account_management/core/utils/colors.dart';
import 'package:account_management/core/utils/text_style.dart';
import 'package:account_management/core/widgets/custom_button.dart';
import 'package:account_management/core/widgets/image_stack.dart';
import 'package:account_management/features/admin/presentation/balance_view/balance_view.dart';
import 'package:account_management/features/admin/presentation/widget/balance_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AddBalanceView extends StatefulWidget {
  const AddBalanceView({super.key});

  @override
  State<AddBalanceView> createState() => _AddBalanceViewState();
}

class _AddBalanceViewState extends State<AddBalanceView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'إضافة رصيد',
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
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Gap(50),
                  BalanceField(
                    balance: 1,
                  ),
                  Gap(75),
                  TextFormField(),
                  Gap(75),
                  CustomButton(
                    text: 'إضافة',
                    textColor: AppColors.whiteColor,
                    onPressed: () {},
                    color: AppColors.primaryColor,
                  ),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
