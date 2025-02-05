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
import 'package:account_management/features/admin/presentation/spend_amount/spend_amount_view.dart';
import 'package:account_management/features/admin/presentation/spend_amount/widget/list_test.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ExpensesView extends StatefulWidget {
  const ExpensesView({super.key});

  @override
  State<ExpensesView> createState() => _ExpensesViewState();
}

class _ExpensesViewState extends State<ExpensesView> {
  String _materialCode = productCodes[0];
  File? imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'عهدة ',
          style: getHeadlineTextStyle(context, color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
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
                        // controller: emtyweightController,
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
                      child: TitleWidget(label: 'المستفيد'),
                    ),
                    const Gap(15),
                    Expanded(
                      flex: 3,
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.greyColor.withAlpha(20),
                        ),
                        child: DropdownButton(
                          value: _materialCode,
                          iconDisabledColor: const Color.fromARGB(255, 0, 0, 0),
                          iconEnabledColor: AppColors.primaryColor,
                          icon: const Icon(
                            Icons.expand_circle_down_rounded,
                          ),
                          isExpanded: true,
                          items: productCodes
                              .map(
                                (newValue) => DropdownMenuItem(
                                  value: newValue,
                                  child: Text(
                                    newValue,
                                    style: getBodyTextStyle(
                                      color: AppColors.textColor,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              //   _materialCode = value.toString();
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
                    Expanded(
                      flex: 2,
                      child: TitleWidget(label: 'ملحوظات   '),
                    ),
                    const Gap(15),
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        maxLines: 3,
                        // controller: emtyweightController,
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
                  onPressed: () {},
                  text: 'حفظ',
                  textColor: AppColors.whiteColor,
                  color: AppColors.primaryColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
