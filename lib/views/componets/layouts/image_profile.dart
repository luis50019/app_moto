import 'package:flutter/cupertino.dart';

class ImageProfile extends StatelessWidget {
  final String url_photo;
  final double heightInput;
  final double widthInput;
  const ImageProfile({super.key, required this.url_photo,this.heightInput = 300, this.widthInput = double.infinity});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.network(url_photo, width: widthInput, height: heightInput, fit: BoxFit.cover,),
    );;
  }
}
