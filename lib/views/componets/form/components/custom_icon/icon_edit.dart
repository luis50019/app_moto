import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomIconEdit extends StatefulWidget {
  final Icon icon;
  final String url;
  const CustomIconEdit({super.key, required this.icon,this.url ="",});

  @override
  State<CustomIconEdit> createState() => _CustomIconEditState();
}

class _CustomIconEditState extends State<CustomIconEdit> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: widget.icon,
        onTap: (){
          context.push(widget.url );
        }
    );
  }
}
