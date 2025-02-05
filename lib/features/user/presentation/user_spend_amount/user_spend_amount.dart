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
import 'package:account_management/features/user/data/user_repo/user_repo.dart';

import 'package:account_management/features/user/presentation/balance_view/user_balance_view.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class UserSpendAmountView extends StatefulWidget {
  const UserSpendAmountView({super.key});

  @override
  State<UserSpendAmountView> createState() => _UserSpendAmountViewState();
}

class _UserSpendAmountViewState extends State<UserSpendAmountView> {
  File? imageFile;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController amountController = TextEditingController();
  TextEditingController noteController = TextEditingController();

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
              pushReplacement(context, UserBalanceView());
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
                child: Column(
                  children: [
                    Gap(50),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: TitleWidget(label: 'إيصال   '),
                        ),
                        const Gap(15),
                        Expanded(
                          flex: 3,
                          child: imageFile != null
                              ? ImagePickerWidget(
                                  image: imageFile!.path,
                                  onCameraTap: () async {
                                    final image = await ImagePickerHelper
                                        .pickImageFromCamera();
                                    if (image != null) {
                                      setState(() {
                                        imageFile = image;
                                      });
                                    } else {
                                      showErrorDialog(
                                          context, 'لم يتم تحديد أي صورة.');
                                    }
                                  },
                                  onGalleryTap: () async {
                                    final image = await ImagePickerHelper
                                        .pickImageFromGallery();
                                    if (image != null) {
                                      setState(() {
                                        imageFile = image;
                                      });
                                    } else {
                                      showErrorDialog(
                                          context, 'لم يتم تحديد أي صورة.');
                                    }
                                    Navigator.pop(context);
                                  },
                                )
                              : DefaultImagePicker(
                                  onCameraTap: () async {
                                    final image = await ImagePickerHelper
                                        .pickImageFromCamera();
                                    if (image != null) {
                                      setState(() {
                                        imageFile = image;
                                      });
                                    } else {
                                      showErrorDialog(
                                          context, 'لم يتم تحديد أي صورة.');
                                    }
                                  },
                                  onGalleryTap: () async {
                                    final image = await ImagePickerHelper
                                        .pickImageFromGallery();
                                    if (image != null) {
                                      setState(() {
                                        imageFile = image;
                                      });
                                    } else {
                                      showErrorDialog(
                                          context, 'لم يتم تحديد أي صورة.');
                                    }
                                    Navigator.pop(context);
                                  },
                                  image: 'assets/images/logo.jpg',
                                ),
                        ),
                      ],
                    ),
                    const Gap(15),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: TitleWidget(label: 'قيمة المبلغ '),
                        ),
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
                          flex: 2,
                          child: TitleWidget(label: 'ملحوظات   '),
                        ),
                        const Gap(15),
                        Expanded(
                          flex: 3,
                          child: TextFormField(
                            maxLines: 3,
                            controller: noteController,
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
                            await UserRepo().creatSpendAmount(
                              amountController.text,
                              noteController.text,
                              imageFile,
                            );
                            pop(context);

                            showSuccessDialog(context, 'تم صرف المبلغ بنجاح');
                          } catch (error) {
                            pop(context);

                            showErrorDialog(
                                context, 'حدث خطأ أثناء صرف المبلغ');
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
          ],
        ),
      ),
    );
  }
}
