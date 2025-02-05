import 'package:account_management/core/functions/navigation.dart';
import 'package:account_management/core/utils/colors.dart';
import 'package:account_management/core/utils/text_style.dart';
import 'package:account_management/core/widgets/image_stack.dart';
import 'package:flutter/material.dart';

import 'Expenses_review_view.dart';

class ExpensesDetailsView extends StatelessWidget {
  const ExpensesDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> ExpensesData = [
      {
        "amount": "500000",
        "note": "عربية",
        "receipt": "صورة",
        "record": "ADMIN"
      },
      {
        "amount": "15000",
        "note": "جهاز تحاليل",
        "receipt": "صورة",
        "record": "ADMIN"
      },
      {
        "amount": "30000",
        "note": "لابتوب",
        "receipt": "صورة",
        "record": "ADMIN"
      },
      {
        "amount": "30000",
        "note": "لابتوب",
        "receipt": "صورة",
        "record": "ADMIN"
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'تفاصيل مصروفات',
          style: getHeadlineTextStyle(context, color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            pushReplacement(context, const ExpensesReviewView());
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            ImageStack(),
            Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  decoration: BoxDecoration(
                    color: AppColors.accentColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'محمد السيد',
                    style: getHeadlineTextStyle(
                      context,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    border: TableBorder.all(color: AppColors.textTitleColor),
                    columns: [
                      DataColumn(
                          label: Text(
                        'قيمة المبلغ',
                        style: getHeadlineTextStyle(context,
                            color: AppColors.textTitleColor),
                      )),
                      DataColumn(
                          label: Text(
                        'ملاحظات',
                        style: getHeadlineTextStyle(context,
                            color: AppColors.textTitleColor),
                      )),
                      DataColumn(
                          label: Text(
                        'إيصال',
                        style: getHeadlineTextStyle(context,
                            color: AppColors.textTitleColor),
                      )),
                      DataColumn(
                          label: Text(
                        'تسجيل',
                        style: getHeadlineTextStyle(context,
                            color: AppColors.textTitleColor),
                      )),
                    ],
                    rows: ExpensesData.map((data) {
                      return DataRow(
                        cells: [
                          DataCell(Text(data["amount"]!)),
                          DataCell(Text(data["note"]!)),
                          DataCell(Text(data["receipt"]!)),
                          DataCell(Text(data["record"]!)),
                        ],
                      );
                    }).toList(),
                  ),
                ),

                const SizedBox(height: 20),

                // المجموع
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  decoration: BoxDecoration(
                    color: AppColors.accentColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'المجموع: ${ExpensesData.fold<int>(0, (sum, item) => sum + int.parse(item["amount"]!))}',
                    style: getHeadlineTextStyle(
                      context,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
