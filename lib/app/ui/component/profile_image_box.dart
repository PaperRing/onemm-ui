import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:onemm/app/controller/store_controller.dart';
import 'package:onemm/app/routes/app_routes.dart';

class ProfileImageBox extends GetView<StoreController> {
  final int userId;
  final bool s3;
  final String photoUrl;

  ProfileImageBox(this.userId, this.s3, this.photoUrl);

  @override
  Widget build(BuildContext context) {
    Future loadOtherUserInfo(id) async {
      showDialog(
          context: context,
          builder: (context) {
            return Center(child: CircularProgressIndicator());
          });
      await controller.likeStoreController.getLikeByUser(id);
      await controller.themeController.getThemeListAllByUser(id);
      Navigator.of(context).pop();
    }

    return InkWell(
      onTap: () async {
        // 다른 유저 상세정보(좋아요 가게, 테마리스트)
        await controller.userController.getOtherUserInfo(userId);

        try {
          await controller.userController.getOtherFollowing(userId);
        } catch (e) {}
        try {
          //나를 팔로우하는사람
          await controller.userController.getOtherFollower(userId);
        } catch (e) {}

        try {
          await controller.userController.getFollowOne(controller.userController.user.id, userId);
          controller.userController.followBool.value = true;
        } catch (e) {
          print(e);
          controller.userController.followBool.value = false;
        }

        await loadOtherUserInfo(userId);
        await Get.toNamed(AppRoutes.OTHER_USER_PAGE, arguments: userId);
      },
      child: s3 == false
          ? Container(
              width: 45.w,
              height: 45.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(image: NetworkImage(photoUrl == null ? '' : "${photoUrl}"), fit: BoxFit.fill),
              ),
            )
          : Container(
              width: 45.w,
              height: 45.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage("https://onemm-bucket.s3.ap-northeast-2.amazonaws.com/profile/${userId}"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
    );
  }
}
