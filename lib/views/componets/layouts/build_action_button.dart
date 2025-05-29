import 'package:flutter/material.dart';

class BuildActionButton extends StatefulWidget {
  final String text;
  final Color color;
  final Function function;
  const BuildActionButton({super.key, required this.text, required this.color, required this.function});

  @override
  State<BuildActionButton> createState() => _BuildActionButtonState();
}

class _BuildActionButtonState extends State<BuildActionButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: widget.color,
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        minimumSize: Size(100, 20),  // Tamaño mínimo aumentado
      ),
      onPressed: ()=>widget.function(),
      child: Text(
        widget.text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,  // Tamaño de fuente aumentado
        ),
      ),
    );
  }
}
