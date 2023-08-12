import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CircleIconButton extends StatelessWidget {
  CircleIconButton(this.onPress, this.icon, [this.fillColor = Colors.white, this.iconColor = Colors.black]);

  final VoidCallback onPress;
  final IconData icon;
  final Color fillColor;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        color: fillColor,
        child: InkWell(
          onTap: onPress,
          child: Padding(
            padding: EdgeInsets.all(10.w),
            child: Icon(icon, size: 20.w, color: iconColor),
          ),
        ),
      ),
    );
  }
}
