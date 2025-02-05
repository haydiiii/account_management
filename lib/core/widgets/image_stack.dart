import 'package:account_management/core/constatnts/image_assets.dart';
import 'package:flutter/material.dart';

class ImageStack extends StatelessWidget {
  const ImageStack({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.7,
      child: Image.asset(
        ImageAssets.logo,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.contain,
      ),
    );
  }
}
