import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailInfoIcon extends StatelessWidget {
  final VoidCallback onpressed;
  final String image;
  final double height;
  final Color color;

  const DetailInfoIcon(this.onpressed, this.image, this.height, this.color, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpressed,
      child: Image.asset(
        image,
        fit: BoxFit.cover,
        color: color,
        height: height,
      ),
    );
  }
}
