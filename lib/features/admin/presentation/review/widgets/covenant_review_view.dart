import 'package:account_management/core/functions/navigation.dart';
import 'package:account_management/core/utils/text_style.dart';
import 'package:account_management/core/widgets/image_stack.dart';
import 'package:account_management/features/admin/data/repo/admin_reo.dart';
import 'package:account_management/features/admin/data/view_model/users_res_model.dart';
import 'package:account_management/features/admin/presentation/review/review_view.dart';
import 'package:account_management/features/admin/presentation/review/widgets/details_convenet.dart';
import 'package:flutter/material.dart';

class CovenantReviewView extends StatefulWidget {
  const CovenantReviewView({super.key});

  @override
  State<CovenantReviewView> createState() => _CovenantReviewViewState();
}

class _CovenantReviewViewState extends State<CovenantReviewView> {
  final AdminReo _adminRepo = AdminReo();
  List<UserModel> usersList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    try {
      List<UserModel> fetchedUsers = await _adminRepo.fetchUsers();
      setState(() {
        usersList = fetchedUsers;
        isLoading = false;
      });
    } catch (e) {
      debugPrint('❌ خطأ أثناء جلب المستخدمين: $e');
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
          'مراجعة عهدة',
          style: getHeadlineTextStyle(context, color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            pushReplacement(context, const ReviewView());
          },
        ),
      ),
      body: Stack(
        children: [
          ImageStack(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : usersList.isEmpty
                    ? const Center(child: Text('لا يوجد مستخدمين'))
                    : Table(
                        border: TableBorder.all(),
                        columnWidths: const {0: FlexColumnWidth()},
                        children: usersList.map((user) {
                          return TableRow(
                            children: [
                              InkWell(
                                onTap: () {
                                  pushReplacement(
                                    context,
                                    CovenantDetailsView(
                                        user: user), // ✅ تمرير بيانات المستخدم
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    user.name,
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
