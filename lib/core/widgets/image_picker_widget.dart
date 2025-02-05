import 'dart:io';

import 'package:account_management/core/utils/colors.dart';
import 'package:flutter/material.dart';

class ImagePickerWidget extends StatelessWidget {
  final VoidCallback onCameraTap;
  final VoidCallback onGalleryTap;
  final String image;

  const ImagePickerWidget({
    required this.onCameraTap,
    required this.onGalleryTap,
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.file(
            File(image),
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        ),
        CircleAvatar(
          radius: 20,
          backgroundColor: Colors.white,
          child: IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return SafeArea(
                    child: Wrap(
                      children: [
                        ListTile(
                          leading: const Icon(
                            Icons.camera_alt,
                            color: AppColors.primaryColor,
                          ),
                          title: const Text('فتح الكاميرا'),
                          onTap: onCameraTap,
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.photo_library_outlined,
                            color: AppColors.primaryColor,
                          ),
                          title: const Text('فتح المعرض'),
                          onTap: onGalleryTap,
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            icon: const Icon(
              Icons.camera_alt_outlined,
              color: AppColors.primaryColor,
              size: 18,
            ),
          ),
        ),
      ],
    );
  }
}
