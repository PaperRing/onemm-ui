import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:onemm/app/controller/user_controller.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../model/follow.dart';
import '../../../routes/app_routes.dart';
import '../../common/app_bar_back_icon_black.dart';
import '../../common/style.dart';
import '../../component/profile_image_box.dart';

class FollowerPage extends GetView<UserController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarBackButtonBlack("팔로워"),
        body: ListView.builder(
            itemCount: controller.myFollowerDto.length,
            itemBuilder: (context, i) {
              return Container(
                padding: EdgeInsets.all(20),
                child: Obx(() {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          ProfileImageBox(controller.myFollowerDto[i].loginId, controller.myFollowerDto[i].s3, controller.myFollowerDto[i].photoUrl),
                          SizedBox(width: 10.w),
                          Text(
                            "${controller.myFollowerDto[i].userName}",
                            style: TextStyle(fontSize: FontSize.BASIC_TEXT.sp),
                          ),
                        ],
                      ),
                      Obx(() {
                        return Row(
                          children: [
                            ZoomTapAnimation(
                              child: InkWell(
                                onTap: () async {
                                  controller.myFollowerDto[i].followBool = !controller.myFollowerDto[i].followBool;
                                  Follow addFollow = Follow(controller.myFollowerDto[i].followingId, controller.myFollowerDto[i].loginId);

                                  controller.myFollowerDto[i].followBool == true
                                      ? await controller.addFollow(addFollow.toJson())
                                      : await controller.deleteFollow(controller.myFollowerDto[i].followingId, controller.myFollowerDto[i].loginId);

                                  await controller.getMyFollowing(controller.myFollowerDto[i].followingId);

                                  Get.offAndToNamed(AppRoutes.FOLLOWER);
                                },
                                child: controller.myFollowerDto[i].followBool
                                    ? Container(
                                        padding: EdgeInsets.symmetric(vertical: 7.h, horizontal: 13.w),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: OnemmColor.GRAY_COLOR_3,
                                        ),
                                        child: Text(
                                          "팔로잉",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: FontSize.MIDDLE_TEXT_13.sp, color: OnemmColor.DARK_GRAY_COLOR, fontWeight: FontWeight.w500),
                                        ),
                                      )
                                    : Container(
                                        padding: EdgeInsets.symmetric(vertical: 7.h, horizontal: 13.w),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: OnemmColor.ONE_MM_COLOR,
                                        ),
                                        child: Text(
                                          "팔로우",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: FontSize.MIDDLE_TEXT_13.sp, color: Colors.white, fontWeight: FontWeight.w500),
                                        ),
                                      ),
                              ),
                            ),
                          ],
                        );
                      })
                    ],
                  );
                }),
              );
            }),
      ),
    );
  }
}
