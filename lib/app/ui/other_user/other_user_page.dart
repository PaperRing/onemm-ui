import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:onemm/app/controller/store_controller.dart';
import 'package:onemm/app/ui/liked_place/component/like_stores.dart';
import 'package:onemm/app/ui/other_user/other_user_follower_page.dart';
import 'package:onemm/app/ui/other_user/other_user_theme_list.dart';

import '../common/app_bar_back_with_block.dart';
import '../common/style.dart';
import 'follow_button.dart';
import 'other_user_folloing_page.dart';

class OtherUserPage extends GetView<StoreController> {
  const OtherUserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarBackWithBlock(""),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          controller.userController.otherUserInfo.s3 == true
                              ? Container(
                                  width: 60.w,
                                  height: 60.h,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: NetworkImage("https://onemm-bucket.s3.ap-northeast-2.amazonaws.com/profile/${controller.userController.otherUserInfo.id}"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              : Container(
                                  width: 60.w,
                                  height: 60.h,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(image: NetworkImage(controller.userController.otherUserInfo.photoUrl ?? ""), fit: BoxFit.fill),
                                  ),
                                ),
                          SizedBox(width: 13.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 5.h),
                              Text(
                                controller.userController.otherUserInfo.name ?? "",
                                style: TextStyle(fontSize: FontSize.TITLE_MIDDLE_16.sp, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10.h),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      controller.userController.otherFollowDto.clear();

                                      try {
                                        if (controller.userController.myFollowing.length == 0) {
                                          await controller.userController.getMyFollowing(controller.userController.user.id);
                                        }
                                      } catch (e) {}

                                      await controller.userController.checkOtherUserFollower(controller.userController.otherFollower, controller.userController.myFollowing);
                                      Get.to(() => OtherUserFollowerPage());
                                    },
                                    child: Row(
                                      children: [
                                        Text("팔로워 ", style: TextStyle(fontSize: FontSize.MIDDLE_TEXT_13.sp, color: OnemmColor.DARK_GRAY_COLOR)),
                                        SizedBox(width: 2.w),
                                        Text("${controller.userController.otherFollower.length} ",
                                            style: TextStyle(fontSize: FontSize.MIDDLE_TEXT_13.sp, fontWeight: FontWeight.bold, color: OnemmColor.DARK_GRAY_COLOR)),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 6.w),
                                  Container(height: 13.h, width: 1.w, color: OnemmColor.DARK_GRAY_COLOR),
                                  SizedBox(width: 8.w),
                                  InkWell(
                                    onTap: () async {
                                      controller.userController.otherFollowDto.clear();

                                      try {
                                        if (controller.userController.myFollowing.length == 0) {
                                          await controller.userController.getMyFollowing(controller.userController.user.id);
                                        }
                                      } catch (e) {}

                                      controller.userController.checkOtherUserFollowing(controller.userController.otherFollowing, controller.userController.myFollowing);
                                      Get.to(() => OtherUserFollowingPage());
                                    },
                                    child: Row(
                                      children: [
                                        Text("팔로잉 ", style: TextStyle(fontSize: FontSize.MIDDLE_TEXT_13.sp, color: OnemmColor.DARK_GRAY_COLOR)),
                                        SizedBox(width: 2.w),
                                        Text("${controller.userController.otherFollowing.length} ",
                                            style: TextStyle(fontSize: FontSize.MIDDLE_TEXT_13.sp, fontWeight: FontWeight.bold, color: OnemmColor.DARK_GRAY_COLOR)),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      FollowButton(),
                    ],
                  );
                }),
              ],
            ),
          ),
          SizedBox(height: 10.h),
          LikeStores(3, "${controller.userController.otherUserInfo.name}의 장소"),
          SizedBox(height: 10.h),
          OtherUserThemeList("${controller.userController.otherUserInfo.name}의 테마리스트")
        ],
      ),
    );
  }
}
