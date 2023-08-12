import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:onemm/app/controller/user_controller.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../model/follow.dart';
import '../../routes/app_routes.dart';
import '../common/app_bar_back_icon_black.dart';
import '../common/style.dart';
import '../component/profile_image_box.dart';
import 'other_user_follow_button.dart';

class OtherUserFollowerPage extends GetView<UserController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarBackButtonBlack("팔로워"),
      body: ListView.builder(
          itemCount: controller.otherFollowDto.length,
          itemBuilder: (context, i) {
            return Container(
              color: Colors.white,
              padding: EdgeInsets.all(20),
              child: Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        ProfileImageBox(controller.otherFollowDto[i].loginId, controller.otherFollowDto[i].s3, controller.otherFollowDto[i].photoUrl),
                        SizedBox(width: 10.w),
                        Text(
                          "${controller.otherFollowDto[i].userName}",
                          style: TextStyle(fontSize: FontSize.BASIC_TEXT.sp),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        ZoomTapAnimation(
                          child: InkWell(
                            onTap: () async {
                              if (controller.userId != 0) {
                                controller.otherFollowDto[i].followBool = !controller.otherFollowDto[i].followBool;

                                Follow addFollow = Follow(controller.user.id, controller.otherFollowDto[i].loginId);
                                controller.otherFollowDto[i].followBool
                                    ? await controller.addFollow(addFollow.toJson())
                                    : await controller.deleteFollow(controller.otherFollowDto[i].loginId, controller.otherFollowDto[i].followingId);
                                await controller.getMyFollowing(controller.otherFollowDto[i].loginId);
                              } else {
                                Get.toNamed(AppRoutes.MYPAGE);
                              }
                            },
                            child: controller.otherFollowDto[i].loginId == controller.userId ? SizedBox() : OtherUserFollowButton(i),
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
