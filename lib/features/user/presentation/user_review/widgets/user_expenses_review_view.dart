import 'package:account_management/core/functions/navigation.dart';
import 'package:account_management/core/utils/colors.dart';
import 'package:account_management/core/utils/text_style.dart';
import 'package:account_management/core/widgets/image_stack.dart';
import 'package:account_management/core/widgets/image_widget.dart';
import 'package:account_management/features/user/data/user_repo/user_repo.dart';
import 'package:account_management/features/user/data/view_model/profile_res_model/profile_res_model.dart';
import 'package:account_management/features/user/data/view_model/user_expenses_res_model/user_expenses_res_model.dart';
import 'package:account_management/features/user/presentation/balance_view/user_balance_view.dart';
import 'package:flutter/material.dart';

class UserExpensesReviewView extends StatefulWidget {
  const UserExpensesReviewView({super.key});

  @override
  State<UserExpensesReviewView> createState() => _UserExpensesReviewViewState();
}

class _UserExpensesReviewViewState extends State<UserExpensesReviewView> {
  bool isLoading = true;
  String? name;
  int? total;
  List<ExpenseModel> expensesModel = [];
  int year = 2025;
  int month = 1;
  List<int> years = [2025, 2026, 2027];
  List<int> months = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });
    try {
      UserRepo userRepo = UserRepo();
      Data? profileData = await userRepo.profileData();
      debugPrint('🔹 اسم المستخدم: ${profileData?.name}');

      if (profileData != null) {
        setState(() {
          name = profileData.name;
        });
      }

      ExpensesResponse? expensesResponse =
          await userRepo.getUserExpenses(year, month);

      if (expensesResponse != null) {
        debugPrint('🔹 استجابة المصروفات: ${expensesResponse.data}');
        debugPrint('🔹 المجموع: ${expensesResponse.total}');

        setState(() {
          expensesModel = expensesResponse.data;
          total = expensesResponse.total;
          isLoading = false;
        });
      } else {
        debugPrint('🔹 لم يتم العثور على بيانات المصروفات.');
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('حدث خطأ أثناء جلب البيانات: $e');
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
          'تفاصيل مصروفات',
          style: getHeadlineTextStyle(context, color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            pushReplacement(context, const UserBalanceView());
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            ImageStack(),
            SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DropdownButton<int>(
                        value: year,
                        items: years.map((int year) {
                          return DropdownMenuItem<int>(
                            value: year,
                            child: Text(year.toString()),
                          );
                        }).toList(),
                        onChanged: (int? newYear) {
                          setState(() {
                            year = newYear!;
                            fetchData();
                          });
                        },
                      ),
                      // Dropdown for month
                      DropdownButton<int>(
                        value: month,
                        items: months.map((int month) {
                          return DropdownMenuItem<int>(
                            value: month,
                            child: Text(month.toString()),
                          );
                        }).toList(),
                        onChanged: (int? newMonth) {
                          setState(() {
                            month = newMonth!;
                            fetchData();
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // اسم المستخدم
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 24),
                    decoration: BoxDecoration(
                      color: AppColors.accentColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      name ?? 'الاسم غير موجود',
                      style: getHeadlineTextStyle(
                        context,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // عرض البيانات في جدول
                  isLoading
                      ? const CircularProgressIndicator()
                      : SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            border: TableBorder.all(
                                color: AppColors.textTitleColor),
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
                            rows: expensesModel.map((data) {
                              return DataRow(
                                cells: [
                                  DataCell(Text(
                                    data.amount.toString(),
                                    style: getTitleTextStyle(context),
                                  )),
                                  DataCell(
                                    Text(
                                      data.notes,
                                      style: getTitleTextStyle(context),
                                    ),
                                  ),
                                  DataCell(
                                    data.image?.isNotEmpty ?? false
                                        ? ImageWidget(imageUrl: data.image)
                                        : Center(
                                            child: Text(
                                            '-',
                                            style: getTitleTextStyle(context),
                                          )),
                                  ),
                                  DataCell(Text(
                                    data.createdBy,
                                    style: getTitleTextStyle(context),
                                  )),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                  const SizedBox(height: 20),
                  // المجموع
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 24),
                    decoration: BoxDecoration(
                      color: AppColors.accentColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'المجموع: $total',
                      style: getHeadlineTextStyle(
                        context,
                      ),
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
