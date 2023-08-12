import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:onemm/app/controller/store_controller.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../model/follow.dart';
import '../../routes/app_routes.dart';
import '../common/style.dart';

class FollowButton extends GetView<StoreController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return InkWell(
        onTap: () async {
          if (controller.userController.uid == '') {
            Get.toNamed(AppRoutes.LOGIN);
            return null;
          }
          controller.userController.followBool.value = !controller.userController.followBool.value;

          Follow newFollower = Follow(controller.userController.user.id, controller.userController.otherUserInfo.id);

          controller.userController.followBool == true
              ? await controller.userController.addFollow(newFollower.toJson())
              : await controller.userController.deleteFollow(controller.userController.user.id, controller.userController.otherUserInfo.id);

          await controller.userController.getOtherFollower(controller.userController.otherUserInfo.id);
        },
        child: followButton(
          controller.userController.followBool.value,
          controller.userController.user.id,
          controller.userController.otherUserInfo.id,
        ),
      );
    });
  }

  Widget followButton(themeBool, userId, themeUserId) {
    if (userId == themeUserId) {
      return SizedBox();
    } else if (themeBool == false) {
      return ZoomTapAnimation(
        child: Container(
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
        ),
      );
    }
    return ZoomTapAnimation(
      child: Container(
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
      ),
    );
  }
}
