import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:onemm/app/controller/user_controller.dart';
import 'package:onemm/app/ui/component/profile_image_box.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../model/follow.dart';
import '../../../routes/app_routes.dart';
import '../../common/app_bar_back_icon_black.dart';
import '../../common/style.dart';

class FollowingPage extends GetView<UserController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarBackButtonBlack("팔로잉"),
      body: ListView.builder(
          itemCount: controller.myFollowingDto.length,
          itemBuilder: (context, i) {
            return Container(
              padding: EdgeInsets.all(20),
              child: Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        ProfileImageBox(controller.myFollowingDto[i].followingId, controller.myFollowingDto[i].s3, controller.myFollowingDto[i].photoUrl),
                        SizedBox(width: 10.w),
                        Text(
                          "${controller.myFollowingDto[i].userName}",
                          style: TextStyle(fontSize: FontSize.BASIC_TEXT.sp),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        ZoomTapAnimation(
                          child: InkWell(
                            onTap: () async {
                              controller.myFollowingDto[i].followBool = !controller.myFollowingDto[i].followBool;
                              print(controller.myFollowingDto[i].followBool);
                              Follow addFollow = Follow(controller.myFollowingDto[i].followingId, controller.myFollowingDto[i].loginId);
                              controller.myFollowingDto[i].followBool
                                  ? await controller.addFollow(addFollow.toJson())
                                  : await controller.deleteFollow(controller.myFollowingDto[i].loginId, controller.myFollowingDto[i].followingId);
                              await controller.getMyFollowing(controller.myFollowingDto[i].loginId);
                              Get.offAndToNamed(AppRoutes.FOLLOWING);
                            },
                            child: controller.myFollowingDto[i].followBool == false
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
                                  ),
                          ),
                        ),
                      ],
                    )
                  ],
                );
              }),
            );
          }),
    );
  }
}
