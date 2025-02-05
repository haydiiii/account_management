import 'package:account_management/core/constatnts/size_config.dart';
import 'package:account_management/core/utils/text_style.dart';
import 'package:flutter/material.dart';

class BalanceField extends StatelessWidget {
  final int balance;
   const BalanceField({
    super.key, required this.balance,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120 * SizeConfig.blockWidth,
      child: TextFormField(
        readOnly: true,
        decoration: InputDecoration(
            hintText: balance.toString(),
            hintStyle: getBodyTextStyle(),
            labelText: 'رصيدك الحالي',
            labelStyle: getBodyTextStyle(
              fontWeight: FontWeight.bold,
            )),
      ),
    );
  }
}
