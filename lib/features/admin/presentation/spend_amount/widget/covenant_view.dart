import 'dart:io';
import 'package:account_management/core/functions/dialogs.dart';
import 'package:account_management/core/functions/navigation.dart';
import 'package:account_management/core/services/image_helper.dart';
import 'package:account_management/core/utils/colors.dart';
import 'package:account_management/core/utils/text_style.dart';
import 'package:account_management/core/widgets/custom_button.dart';
import 'package:account_management/core/widgets/default_image_widget.dart';
import 'package:account_management/core/widgets/image_picker_widget.dart';
import 'package:account_management/core/widgets/image_stack.dart';
import 'package:account_management/core/widgets/title_widgets.dart';
import 'package:account_management/features/admin/data/repo/admin_reo.dart';
import 'package:account_management/features/admin/data/view_model/users_res_model.dart';
import 'package:account_management/features/admin/presentation/spend_amount/spend_amount_view.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CovenantView extends StatefulWidget {
  const CovenantView({super.key});

  @override
  State<CovenantView> createState() => _CovenantViewState();
}

class _CovenantViewState extends State<CovenantView> {
  List<UserModel> usersList = [];
  String? _selectedUser;
  final AdminReo _adminRepo = AdminReo();
  File? imageFile;
  bool isLoading = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController amountController = TextEditingController();
  TextEditingController noteController = TextEditingController();

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
        _selectedUser =
            usersList.isNotEmpty ? usersList[0].id.toString() : null;
        isLoading = false;
      });
    } catch (e) {
      debugPrint('Error loading users: $e');
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
          'عهدة ',
          style: getHeadlineTextStyle(context, color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            pushReplacement(context, SpendAmountView());
          },
        ),
      ),
      body: Stack(
        children: [
          ImageStack(),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Gap(50),
                    Row(
                      children: [
                        Expanded(flex: 2, child: TitleWidget(label: 'إيصال')),
                        const Gap(15),
                        Expanded(
                          flex: 3,
                          child: imageFile != null
                              ? ImagePickerWidget(
                                  image: imageFile!.path,
                                  onCameraTap: _pickImageFromCamera,
                                  onGalleryTap: _pickImageFromGallery,
                                )
                              : DefaultImagePicker(
                                  onCameraTap: _pickImageFromCamera,
                                  onGalleryTap: _pickImageFromGallery,
                                  image: 'assets/images/logo.jpg',
                                ),
                        ),
                      ],
                    ),
                    const Gap(15),
                    Row(
                      children: [
                        Expanded(
                            flex: 2, child: TitleWidget(label: 'قيمة المبلغ')),
                        const Gap(15),
                        Expanded(
                          flex: 3,
                          child: TextFormField(
                            controller: amountController,
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return 'الرجاء إدخال قيمة المبلغ';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const Gap(15),
                    Row(
                      children: [
                        Expanded(
                            flex: 2, child: TitleWidget(label: 'المستفيد')),
                        const Gap(15),
                        Expanded(
                          flex: 3,
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.greyColor.withAlpha(20),
                            ),
                            child: isLoading
                                ? Center(child: CircularProgressIndicator())
                                : DropdownButton(
                                    value: _selectedUser,
                                    isExpanded: true,
                                    icon: const Icon(
                                        Icons.expand_circle_down_rounded),
                                    iconDisabledColor: Colors.black,
                                    iconEnabledColor: AppColors.primaryColor,
                                    items: usersList.map((user) {
                                      return DropdownMenuItem(
                                        value: user.id.toString(),
                                        child: Text(user.name,
                                            style: getBodyTextStyle(
                                              color: AppColors.textColor,
                                            )),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedUser = value.toString();
                                      });
                                    },
                                  ),
                          ),
                        ),
                      ],
                    ),
                    const Gap(15),
                    Row(
                      children: [
                        Expanded(flex: 2, child: TitleWidget(label: 'ملحوظات')),
                        const Gap(15),
                        Expanded(
                          flex: 3,
                          child: TextFormField(
                            controller: noteController,
                            maxLines: 3,
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return 'الرجاء إدخال ملاحظات';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const Gap(15),
                    CustomButton(
                      onPressed: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) => Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primaryColor,
                              ),
                            ),
                          );
                          try {
                            await AdminReo().createAdminConvenant(
                              amountController.text,
                              noteController.text,
                              imageFile,
                              int.parse(_selectedUser!),
                            );
                            pop(context);

                            showSuccessDialog(context, 'تم عهدة المبلغ بنجاح');
                          } catch (error) {
                            pop(context);

                            showErrorDialog(
                                context, 'حدث خطأ أثناء عهدة المبلغ');
                          }
                          // Call the API
                        }
                      },
                      text: 'حفظ',
                      textColor: AppColors.whiteColor,
                      color: AppColors.primaryColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickImageFromCamera() async {
    final image = await ImagePickerHelper.pickImageFromCamera();
    if (image != null) {
      setState(() {
        imageFile = image;
      });
    } else {
      showErrorDialog(context, 'لم يتم تحديد أي صورة.');
    }
  }

  Future<void> _pickImageFromGallery() async {
    final image = await ImagePickerHelper.pickImageFromGallery();
    if (image != null) {
      setState(() {
        imageFile = image;
      });
    } else {
      showErrorDialog(context, 'لم يتم تحديد أي صورة.');
    }
  }
}
