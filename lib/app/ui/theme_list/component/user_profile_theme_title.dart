import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controller/store_controller.dart';
import '../../common/style.dart';

class UserProfileThemeTitle extends GetView<StoreController> {
  const UserProfileThemeTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              Icons.account_circle,
              size: 45.sp,
              color: OnemmColor.DARK_GRAY_COLOR,
            ),
            SizedBox(width: 8.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${controller.themeController.themeItems.userName}님의 테마리스트",
                    style: TextStyle(
                      fontSize: FontSize.BASIC_TEXT.sp,
                    )),
                Text(controller.themeController.themeItems.title,
                    style: TextStyle(
                      fontSize: FontSize.TITLE_MIDDLE_17.sp,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
          ],
        ),
        Icon(
          Icons.keyboard_arrow_right,
          color: OnemmColor.GRAY_COLOR_10,
        )
      ],
    );
  }
}
