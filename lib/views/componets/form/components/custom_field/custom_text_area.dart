import 'package:app_ocotaxi/core/constants/app_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextArea extends StatefulWidget {
  const CustomTextArea({super.key});

  @override
  State<CustomTextArea> createState() => _CustomTextAreaState();
}

class _CustomTextAreaState extends State<CustomTextArea> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Descripcion", style: AppStyle.labelText),
        Text("Indique si lleva equipaje o algo para cargar en la unidad"),
        SizedBox(
          height: 180,
          child: TextFormField(
            maxLines: null,
            expands: true,
            keyboardType: TextInputType.multiline,
            textAlignVertical: TextAlignVertical.top,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Escribe tu mensaje aquí',
            ),
          ),
        ),
      ],
    );
  }
}
