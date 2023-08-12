import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:onemm/app/ui/common/style.dart';

class MainWalk extends StatelessWidget {
  const MainWalk({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: CustomStyle.PADDING,
      child: startButton(),
    );
  }

  Widget startButton() {
    return ElevatedButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(height: 100.h, child: Lottie.asset('assets/walk/walk.json')),
          Text('', style: TextStyle(color: Colors.black87, fontSize: 18.sp)),
          SizedBox(width: 30.w),
        ],
      ),
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 30.w),
        fixedSize: Size(100.w, 100.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.w)),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
    );
  }
}
