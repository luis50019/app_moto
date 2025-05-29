import 'package:app_ocotaxi/core/constants/app_styles.dart';
import 'package:app_ocotaxi/core/constants/border_style.dart';
import 'package:app_ocotaxi/core/constants/routes.dart';
import 'package:app_ocotaxi/views/componets/form/components/custom_icon/icon_edit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomInput extends StatefulWidget {
  final String valueInitial;
  final String url;
  final String labelText;
  final String? placeholder;
  final bool readOnly;
  final bool iconView;
  const CustomInput({
    super.key,
    this.valueInitial = "",
    this.url = "",
    required this.labelText,
    this.placeholder = "Ingrese la informacion",this.readOnly =false, this.iconView = false,
  });

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.labelText,style: AppStyle.labelText),
        TextFormField(
          readOnly: widget.readOnly,
          decoration: InputDecoration(
            suffixIcon: widget.iconView?CustomIconEdit(icon: Icon(Icons.edit), url: widget.url,):null,
            enabledBorder: CustomBorderStyle.borderEnable,
            focusedBorder: CustomBorderStyle.borderFocus,
            errorBorder: CustomBorderStyle.borderError,
            hintText: widget.placeholder,
          ),
          initialValue: widget.valueInitial,
        ),
      ],
    );
  }
}
