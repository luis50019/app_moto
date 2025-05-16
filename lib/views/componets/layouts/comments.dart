import 'package:app_ocotaxi/models/driver/driver_info_id.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/app_styles.dart';
import 'carrousel_comments.dart';

class Comments extends StatefulWidget {
  final List<Review> data;
  const Comments({super.key, required this.data});

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Comentarios", style: AppStyle.textCardDark),
            const Icon(Icons.add, size: 25),
          ],
        ),
        const SizedBox(height: 10),
        if (widget.data != null &&
            widget.data.isNotEmpty)
          CarrouselComments(info: widget.data)
        else
          const Text("Sin comentarios por el momento"),
      ],
    );
  }
}
