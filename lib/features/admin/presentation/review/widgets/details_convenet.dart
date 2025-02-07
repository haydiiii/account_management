import 'package:account_management/core/functions/navigation.dart';
import 'package:account_management/core/utils/colors.dart';
import 'package:account_management/core/utils/text_style.dart';
import 'package:account_management/core/widgets/image_stack.dart';
import 'package:account_management/core/widgets/image_widget.dart';
import 'package:account_management/features/admin/data/repo/admin_reo.dart';
import 'package:account_management/features/admin/data/view_model/admin_convenant_for_employee.dart';
import 'package:account_management/features/admin/data/view_model/users_res_model.dart';
import 'package:flutter/material.dart';

import 'covenant_review_view.dart';

class CovenantDetailsView extends StatefulWidget {
  final UserModel user;

  const CovenantDetailsView({super.key, required this.user});

  @override
  State<CovenantDetailsView> createState() => _CovenantDetailsViewState();
}

class _CovenantDetailsViewState extends State<CovenantDetailsView> {
  final AdminReo _adminRepo = AdminReo();
  CovenantData? covenantData;
  bool isLoading = true;

  // القيم الافتراضية للسنة والشهر
  int selectedYear = DateTime.now().year;
  int selectedMonth = DateTime.now().month;

  // قائمة السنوات (آخر 5 سنوات)
  List<int> years = List.generate(5, (index) => DateTime.now().year - index);

  // قائمة الأشهر (1 إلى 12)
  List<int> months = List.generate(12, (index) => index + 1);

  @override
  void initState() {
    super.initState();
    _fetchUserCovenant();
  }

  Future<void> _fetchUserCovenant() async {
    setState(() {
      isLoading = true;
    });

    try {
      CovenantData fetchedData = await _adminRepo.fetchCovenantForEmployee(
        id: widget.user.id,
        year: selectedYear, // ✅ فلترة بالسنة
        month: selectedMonth, // ✅ فلترة بالشهر
      );

      setState(() {
        covenantData = fetchedData;
        isLoading = false;
      });
    } catch (e) {
      debugPrint('❌ خطأ أثناء جلب بيانات العهدة: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'تفاصيل عهدة',
          style: getHeadlineTextStyle(context, color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            pushReplacement(context, const CovenantReviewView());
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
                // 🔹 **فلترة بالسنة والشهر**
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // ✅ اختيار السنة
                    DropdownButton<int>(
                      value: selectedYear,
                      items: years.map((int year) {
                        return DropdownMenuItem<int>(
                          value: year,
                          child: Text(year.toString()),
                        );
                      }).toList(),
                      onChanged: (int? newYear) {
                        if (newYear != null) {
                          setState(() {
                            selectedYear = newYear;
                          });
                          _fetchUserCovenant(); // تحديث البيانات
                        }
                      },
                    ),

                    // ✅ اختيار الشهر
                    DropdownButton<int>(
                      value: selectedMonth,
                      items: months.map((int month) {
                        return DropdownMenuItem<int>(
                          value: month,
                          child: Text(month.toString()),
                        );
                      }).toList(),
                      onChanged: (int? newMonth) {
                        if (newMonth != null) {
                          setState(() {
                            selectedMonth = newMonth;
                          });
                          _fetchUserCovenant(); // تحديث البيانات
                        }
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // ✅ **تحميل البيانات أو عرض الجدول**
                isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : covenantData == null || covenantData!.items.isEmpty
                        ? const Center(child: Text('لا توجد بيانات للعهدة'))
                        : Expanded(
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 24),
                                  decoration: BoxDecoration(
                                    color: AppColors.accentColor,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    widget.user.name,
                                    style: getHeadlineTextStyle(context),
                                  ),
                                ),
                                const SizedBox(height: 20),

                                // ✅ **عرض جدول العهدة**
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: DataTable(
                                    border: TableBorder.all(
                                        color: AppColors.textTitleColor),
                                    columns: [
                                      DataColumn(
                                          label: Text('💰 قيمة المبلغ',
                                              style: getHeadlineTextStyle(
                                                  context,
                                                  color: AppColors
                                                      .textTitleColor))),
                                      DataColumn(
                                          label: Text('📝 ملاحظات',
                                              style: getHeadlineTextStyle(
                                                  context,
                                                  color: AppColors
                                                      .textTitleColor))),
                                      DataColumn(
                                          label: Text('📷 إيصال',
                                              style: getHeadlineTextStyle(
                                                  context,
                                                  color: AppColors
                                                      .textTitleColor))),
                                      DataColumn(
                                          label: Text('👤 تسجيل',
                                              style: getHeadlineTextStyle(
                                                  context,
                                                  color: AppColors
                                                      .textTitleColor))),
                                    ],
                                    rows: covenantData!.items.map((data) {
                                      return DataRow(
                                        cells: [
                                          DataCell(Text(
                                            data.amount.toString(),
                                            style: getTitleTextStyle(context),
                                          )), // ✅ قيمة المبلغ
                                          DataCell(Text(
                                            data.notes,
                                            style: getTitleTextStyle(context),
                                          )), // ✅ ملاحظات
                                          DataCell(
                                            data.image?.isNotEmpty ?? false
                                                ? ImageWidget(
                                                    imageUrl: data.image)
                                                : Center(
                                                    child: Text(
                                                      '-',
                                                      style: getTitleTextStyle(
                                                          context),
                                                    ),
                                                  ),
                                          ), // ✅ صورة الإيصال
                                          DataCell(Text(
                                            data.createdBy,
                                            style: getTitleTextStyle(context),
                                          )), // ✅ من قام بالتسجيل
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
                                    '💵 المجموع: ${covenantData!.total}',
                                    style: getHeadlineTextStyle(context),
                                  ),
                                ),
                              ],
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
