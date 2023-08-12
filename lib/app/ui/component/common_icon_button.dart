import 'package:flutter/material.dart';

class CommonIconButton extends StatelessWidget {
  final String image;
  final Color? color;
  final double height;
  final VoidCallback onPress;

  CommonIconButton(this.image, this.color, this.height, this.onPress);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      alignment: Alignment.centerRight,
      constraints: BoxConstraints(),
      padding: EdgeInsets.zero,
      icon: Image.asset(
        image,
        color: color,
        height: height,
      ),
      onPressed: onPress,
    );
  }
}
