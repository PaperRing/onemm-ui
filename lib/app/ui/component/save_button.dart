import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../common/style.dart';

class SaveButton extends StatelessWidget {
  final VoidCallback onPress;

  SaveButton(this.onPress);

  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      child: InkWell(
        onTap: onPress,
        child: Container(
          decoration: BoxDecoration(
            color: OnemmColor.ONE_MM_COLOR,
            borderRadius: BorderRadius.circular(15),
          ),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Text(
            "등록하기",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: FontSize.BASIC_TEXT.sp, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
