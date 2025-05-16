import 'package:app_ocotaxi/core/constants/app_styles.dart';
import 'package:flutter/cupertino.dart';

class Titlepage extends StatelessWidget {
  final String text1;
  final String text2;
  const Titlepage({super.key, required this.text1,this.text2=""});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left:30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(this.text1, style: AppStyle.textH1,),
          Padding(
            padding: EdgeInsets.only(left: 100.0),
            child: Text(this.text2, style: AppStyle.textH1,),
          ),
        ],
      ),
    );
  }
}
