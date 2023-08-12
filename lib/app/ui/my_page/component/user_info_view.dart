import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:onemm/app/controller/store_controller.dart';
import 'package:onemm/app/ui/my_page/component/follower_page.dart';
import 'package:onemm/app/ui/my_page/component/question_page.dart';

import '../../../routes/app_routes.dart';
import '../../common/style.dart';
import 'following_page.dart';

class UserInfoView extends GetView<StoreController> {
  const UserInfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(
        () {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Padding(
                padding: CustomStyle.PADDING,
                child: Obx(() {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      controller.userController.user.s3 == true
                          ? ClipOval(
                              child: Image(
                                image: NetworkImage("https://onemm-bucket.s3.ap-northeast-2.amazonaws.com/profile/${controller.userController.user.id}"),
                                fit: BoxFit.cover,
                                width: 75.w,
                                height: 70.h,
                                key: ValueKey(new Random().nextInt(100)),
                              ),
                            )
                          : Container(
                              width: 80.w,
                              height: 80.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(image: NetworkImage(controller.userController.photoUrl), fit: BoxFit.fill),
                              ),
                            ),
                      SizedBox(width: 15.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(height: 15.h),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 3),
                                child: Text(
                                  controller.userController.user.name ?? "",
                                  style: TextStyle(fontSize: FontSize.TITLE_MIDDLE_17.sp, fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(width: 8.w),
                              InkWell(
                                  onTap: () {
                                    Get.toNamed(AppRoutes.MY_EDIT);
                                  },
                                  child: Image.asset(
                                    'assets/icons/edit.png',
                                    height: 18.sp,
                                    // color: OnemmColor.DARK_GRAY_COLOR,
                                  ))
                            ],
                          ),
                          SizedBox(height: 15.h),
                          Row(
                            children: [
                              InkWell(
                                onTap: () async {
                                  controller.userController.myFollowerDto.clear();
                                  controller.userController.checkFollower();
                                  Get.to(() => FollowerPage());
                                },
                                child: Row(
                                  children: [
                                    Text("팔로워 ", style: TextStyle(fontSize: FontSize.BASIC_TEXT.sp, color: OnemmColor.DARK_GRAY_COLOR)),
                                    SizedBox(width: 3.w),
                                    Text("${controller.userController.myFollower.length} ", style: TextStyle(fontSize: FontSize.BASIC_TEXT.sp, fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Container(height: 13.h, width: 1.w, color: OnemmColor.DARK_GRAY_COLOR),
                              SizedBox(width: 10.w),
                              InkWell(
                                onTap: () async {
                                  controller.userController.myFollowingDto.clear();
                                  controller.userController.checkFollowing();
                                  Get.to(() => FollowingPage());
                                },
                                child: Row(
                                  children: [
                                    Text("팔로잉 ", style: TextStyle(fontSize: FontSize.BASIC_TEXT.sp, color: OnemmColor.DARK_GRAY_COLOR)),
                                    SizedBox(width: 3.w),
                                    Text("${controller.userController.myFollowing.length} ", style: TextStyle(fontSize: FontSize.BASIC_TEXT.sp, fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  );
                }),
              ),
              SizedBox(height: 15.h),
              Container(height: 3.h, color: OnemmColor.GRAY_COLOR_1),
              SizedBox(height: 10.h),
              Padding(
                padding: CustomStyle.PADDING,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            Get.toNamed(AppRoutes.MYPAGE_REVIEW);
                          },
                          child: buildText("내가 남긴 리뷰 "),
                        ),
                        Text(
                          "${controller.reviewController.myReviewList.length}",
                          style: TextStyle(fontSize: FontSize.BASIC_TEXT.sp, color: Colors.black38),
                        )
                      ],
                    ),
                    // Container(height: 1.h, width: double.infinity, color: OnemmColor.GRAY_COLOR_3),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            Get.toNamed(AppRoutes.MY_THEME_LIST);
                          },
                          child: buildText("내 테마리스트"),
                        ),
                        Text(
                          "${controller.themeController.themeListByUser.length}",
                          style: TextStyle(fontSize: FontSize.BASIC_TEXT.sp, color: Colors.black38),
                        )
                      ],
                    ),
                    // Container(height: 1.h, width: double.infinity, color: OnemmColor.GRAY_COLOR_3),
                    GestureDetector(
                      onTap: () {
                        Get.to(const QuestionPage());
                      },
                      child: buildText("1:1 문의 "),
                    ),
                    // Container(height: 1.h, width: double.infinity, color: OnemmColor.GRAY_COLOR_3),
                    GestureDetector(
                      onTap: () async {
                        await controller.userController.logOut();
                        controller.userController.uid = '';
                        print("uid ${controller.userController.uid}");
                        controller.searchController.record.value = [];
                        print(" record ${controller.searchController.record}");
                      },
                      child: buildText("로그아웃 "),
                    ),
                    // Container(height: 1.h, width: double.infinity, color: OnemmColor.GRAY_COLOR_3),
                    GestureDetector(
                      onTap: () async {
                        return showDialog<void>(
                          //다이얼로그 위젯 소환
                          context: context,
                          barrierDismissible: false, // 다이얼로그 이외의 바탕 눌러도 안꺼지도록 설정
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('탈퇴하시나요? 🥺'),
                              content: SingleChildScrollView(
                                child: ListBody(
                                  children: <Widget>[
                                    Text('저장한 데이터는 다 삭제돼요.'),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  child: Text('탈퇴하기'),
                                  onPressed: () async {
                                    await controller.userController.deleteUser();
                                    await controller.userController.deleteUserDB(controller.userController.user.id);
                                    controller.userController.uid.value = '';

                                    Get.back();
                                  },
                                ),
                                TextButton(
                                  child: Text('취소'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: buildText("탈퇴 "),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  buildText(text) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Text(
        text,
        style: TextStyle(
          fontSize: FontSize.BASIC_TEXT.sp,
          color: OnemmColor.COMMON_TEXT_COLOR,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
