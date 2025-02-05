import 'package:account_management/core/functions/navigation.dart';
import 'package:account_management/core/utils/text_style.dart';
import 'package:account_management/core/widgets/image_stack.dart';
import 'package:account_management/features/admin/presentation/balance_view/balance_view.dart';
import 'package:account_management/features/admin/presentation/review/widgets/details_convenet.dart';
import 'package:flutter/material.dart';

class CovenantReviewView extends StatefulWidget {
  const CovenantReviewView({super.key});

  @override
  State<CovenantReviewView> createState() => _CovenantReviewViewState();
}

class _CovenantReviewViewState extends State<CovenantReviewView> {
  // قائمة بأسماء المستخدمين
  final List<String> users = [
    'محمد احمد',
    'ابراهيم',
    'ابراهيم',
    'ابراهيم',
    'ابراهيم',
    'ابراهيم',
    'ابراهيم',
    'ابراهيم',
    'ابراهيم',
    'ابراهيم',
    'ابراهيم',
    'ابراهيم',
    'ابراهيم',
    'ابراهيم',
    'ابراهيم',
    'ابراهيم',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'مراجعة عهدة',
          style: getHeadlineTextStyle(context, color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            pushReplacement(context, const BalanceView());
          },
        ),
      ),
      body: Stack(
        children: [
          ImageStack(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Table(
              border: TableBorder.all(),
              columnWidths: const {
                0: FlexColumnWidth(),
              },
              children: users.map((name) {
                return TableRow(
                  children: [
                    InkWell(
                      onTap: () {
                        pushReplacement(context, CovenantDetailsView());
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          name,
                          textAlign: TextAlign.right,
                          style: getBodyTextStyle(),
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
