import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; // Necesario para FadeInImage

class ImageAvatarDriver extends StatefulWidget {
  final String urlImage;
  const ImageAvatarDriver({
    super.key,
    this.urlImage = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRb4E9K7e2KLbq7aGQ7Ss04x3QHiJpYAfW1lw&s" //"https://res.cloudinary.com/dzqytawx9/image/upload/v1748449536/cxguf5csy06whdoz0nhn.png"
  });

  @override
  State<ImageAvatarDriver> createState() => _ImageAvatarDriverState();
}

class _ImageAvatarDriverState extends State<ImageAvatarDriver> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: FadeInImage(
        placeholder: AssetImage('assets/images/logo.png'),
        image: NetworkImage(widget.urlImage), // Usa NetworkImage directamente
        width: 100,
        height: 100,
        fit: BoxFit.cover,
        imageErrorBuilder: (context, error, stackTrace) {
          return Image.asset(
            'assets/imagenes/logo.png', // Fallback si hay error
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }
}