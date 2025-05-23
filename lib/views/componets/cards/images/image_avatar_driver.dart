import 'package:flutter/cupertino.dart';

class ImageAvatarDriver extends StatefulWidget {
  final String urlImage;
  const ImageAvatarDriver({super.key, required this.urlImage});

  @override
  State<ImageAvatarDriver> createState() => _ImageAvatarDriverState();
}

class _ImageAvatarDriverState extends State<ImageAvatarDriver> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.network(
        widget.urlImage,
        width: 100,
        height: 100,
        fit: BoxFit.cover,
      ),
    );
  }
}
