import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:onemm/app/controller/user_controller.dart';

import '../common/style.dart';

class OtherUserFollowButton extends GetView<UserController> {
  int i;

  OtherUserFollowButton(this.i);

  @override
  Widget build(BuildContext context) {
    return controller.otherFollowDto[i].followBool == false
        ? Container(
            padding: EdgeInsets.symmetric(vertical: 7.h, horizontal: 13.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: OnemmColor.ONE_MM_COLOR,
            ),
            child: Text(
              "팔로우",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: FontSize.BASIC_TEXT.sp, color: Colors.white, fontWeight: FontWeight.w500),
            ),
          )
        : Container(
            padding: EdgeInsets.symmetric(vertical: 7.h, horizontal: 13.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: OnemmColor.GRAY_COLOR_3,
            ),
            child: Text(
              "팔로잉",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: FontSize.BASIC_TEXT.sp, color: OnemmColor.DARK_GRAY_COLOR, fontWeight: FontWeight.w500),
            ),
          );
  }
}
