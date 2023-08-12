import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/style.dart';

class WalkRecording extends StatelessWidget {
  const WalkRecording({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return walk();
  }

  Widget walk() {
    return Container(
      // height: 250,
      padding: EdgeInsets.symmetric(vertical: 30.w),
      decoration: BoxDecoration(
        // borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(3.0, 0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          startButton(),
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                walkComponent('assets/icons/fire.png', Colors.red, '200', 'Total Calories'),
                Container(height: 35.h, width: 1.w, color: OnemmColor.GRAY_COLOR_3),
                walkComponent('assets/icons/footprints.png', Colors.blue, '1,000', 'Total Steps'),
                Container(height: 35.h, width: 1.w, color: OnemmColor.GRAY_COLOR_3),
                walkComponent('assets/icons/route.png', Colors.green, '1.0', 'Total KM'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget startButton() {
    return ElevatedButton(
      child: Image.asset(
        "assets/icons/play-button.png",
        color: OnemmColor.ONE_MM_COLOR_7,
        height: 70.h,
      ),
      onPressed: () {},
      style: ElevatedButton.styleFrom(primary: Colors.white, elevation: 0.0),
    );
  }

  Widget walkComponent(icon, icon_color, number, text) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 10.h),
        Image.asset(icon, height: 20.h, color: icon_color),
        SizedBox(height: 10.h),
        Text(number, style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w900)),
        SizedBox(height: 4.h),
        Text(text, style: TextStyle(fontSize: 10.sp, color: OnemmColor.GRAY_COLOR_8))
      ],
    );
  }
}
