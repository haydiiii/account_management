import 'package:account_management/core/widgets/image_view_screen_widget.dart';
import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  final String? imageUrl;

  const ImageWidget({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null || imageUrl!.isEmpty) {
      return const Text('-');
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ImageViewerScreen(imageUrl: imageUrl!),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        child: Image.network(
          imageUrl!,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              return child;
            } else {
              return const CircularProgressIndicator();
            }
          },
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.error);
          },
        ),
      ),
    );
  }
}
