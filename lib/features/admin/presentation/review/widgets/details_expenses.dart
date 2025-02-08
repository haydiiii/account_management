import 'dart:convert';

import 'package:account_management/features/admin/data/view_model/users_res_model.dart';
import 'package:flutter/material.dart';
import 'package:account_management/core/functions/navigation.dart';
import 'package:account_management/core/utils/colors.dart';
import 'package:account_management/core/utils/text_style.dart';
import 'package:account_management/core/widgets/image_widget.dart';
import 'package:account_management/features/admin/data/repo/admin_reo.dart';
import 'package:account_management/features/admin/data/view_model/expenses_user_res_model.dart';
import 'package:account_management/features/admin/presentation/review/widgets/expenses_review_view.dart';

class ExpensesDetailsView extends StatefulWidget {
  final EmployeeExpense? expenseData;
  final UserModel userr;

  const ExpensesDetailsView({super.key, this.expenseData, required this.userr});

  @override
  State<ExpensesDetailsView> createState() => _ExpensesDetailsViewState();
}

class _ExpensesDetailsViewState extends State<ExpensesDetailsView> {
  final AdminReo _adminRepo = AdminReo();
  EmployeeExpense? expenseData;
  bool isLoading = true;

  int selectedYear = DateTime.now().year;
  int selectedMonth = DateTime.now().month;

  List<int> years = List.generate(5, (index) => DateTime.now().year - index);
  List<int> months = List.generate(12, (index) => index + 1);

  @override
  void initState() {
    super.initState();
    debugPrint(
        "📌 البيانات المستلمة في تفاصيل المصروفات: ID = ${widget.userr.id}, Name = ${widget.userr.name}");
    _fetchUserExpenses();
  }

  Future<void> _fetchUserExpenses() async {
    setState(() {
      isLoading = true;
    });

    debugPrint(
        "📡 طلب بيانات المصروفات للموظف: ID = ${widget.userr.id}, Name = ${widget.userr.name}");

    try {
      EmployeeExpense fetchedData = await _adminRepo.fetchExpensesForEmployee(
        id: widget.userr.id, // ✅ الطلب خاص بالمستخدم المحدد فقط
        year: selectedYear,
        month: selectedMonth,
      );

      debugPrint("📡 البيانات المستلمة من API: ${jsonEncode(fetchedData)}");

      setState(() {
        // ✅ تحديث البيانات بحيث تظل لكل مستخدم مصروفاته فقط
        expenseData = fetchedData;
        isLoading = false;
      });
    } catch (e) {
      debugPrint("❌ خطأ أثناء جلب المصروفات: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("📊 عدد المصروفات المعروضة: ${expenseData?.data.length ?? 0}");

    return Scaffold(
      appBar: AppBar(
        title: Text('تفاصيل المصروفات',
            style: getHeadlineTextStyle(context, color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => pushReplacement(context, const ExpensesReviewView()),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<int>(
                  value: selectedYear,
                  items: years
                      .map((year) => DropdownMenuItem(
                          value: year, child: Text(year.toString())))
                      .toList(),
                  onChanged: (newYear) {
                    if (newYear != null) {
                      setState(() {
                        selectedYear = newYear;
                      });
                      _fetchUserExpenses();
                    }
                  },
                ),
                DropdownButton<int>(
                  value: selectedMonth,
                  items: months
                      .map((month) => DropdownMenuItem(
                          value: month, child: Text(month.toString())))
                      .toList(),
                  onChanged: (newMonth) {
                    if (newMonth != null) {
                      setState(() {
                        selectedMonth = newMonth;
                      });
                      _fetchUserExpenses();
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : expenseData == null || expenseData!.data.isEmpty
                    ? const Center(
                        child: Text('لا توجد بيانات المصروفات لهذا الموظف'))
                    : Expanded(
                        child: ListView(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 24),
                              decoration: BoxDecoration(
                                color: AppColors.accentColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                widget.userr.name,
                                style: getHeadlineTextStyle(context),
                              ),
                            ),
                            const SizedBox(height: 20),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: DataTable(
                                border: TableBorder.all(
                                    color: AppColors.textTitleColor),
                                columns: [
                                  DataColumn(
                                      label: Text('💰 المبلغ',
                                          style:
                                              getHeadlineTextStyle(context))),
                                  DataColumn(
                                      label: Text('📝 ملاحظات',
                                          style:
                                              getHeadlineTextStyle(context))),
                                  DataColumn(
                                      label: Text('📷 إيصال',
                                          style:
                                              getHeadlineTextStyle(context))),
                                  DataColumn(
                                      label: Text('👤 بواسطة',
                                          style:
                                              getHeadlineTextStyle(context))),
                                ],
                                rows: expenseData!.data.map((data) {
                                  return DataRow(
                                    cells: [
                                      DataCell(Text(data.amount.toString(),
                                          style: getBodyTextStyle())),
                                      DataCell(Text(data.notes,
                                          style: getBodyTextStyle())),
                                      DataCell(
                                        data.image?.isNotEmpty ?? false
                                                ? ImageWidget(
                                                    imageUrl: data.image)
                                                : Center(
                                                    child: Text(
                                                      '-',
                                                    style: getTitleTextStyle(
                                                        context))),
                                      ),
                                      DataCell(Text(data.createdBy,
                                          style: getBodyTextStyle())),
                                    ],
                                  );
                                }).toList(),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 24),
                              decoration: BoxDecoration(
                                color: AppColors.accentColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '💵 المجموع: ${expenseData!.total}',
                                style: getHeadlineTextStyle(context),
                              ),
                            ),
                          ],
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}
