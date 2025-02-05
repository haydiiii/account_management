import 'package:flutter/material.dart';

class BackgrondImage extends StatelessWidget {
  final Widget child;

  const BackgrondImage({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/images/background.jpg', // مسار الصورة
            fit: BoxFit.cover,
          ),
        ),
        child,
      ],
    );
  }
}
