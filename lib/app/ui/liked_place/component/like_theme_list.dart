import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:onemm/app/controller/store_controller.dart';

import '../../../routes/app_routes.dart';
import '../../common/style.dart';
import '../../component/profile_image_box.dart';

class LikeThemeList extends GetView<StoreController> {
  final String title;

  LikeThemeList(this.title);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 15.w, horizontal: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: FontSize.BASIC_TEXT.sp, fontWeight: FontWeight.bold),
              ),
              Text(
                "+ ${controller.themeController.likeThemeList.length}",
                style: TextStyle(fontSize: FontSize.BASIC_TEXT.sp, fontWeight: FontWeight.bold, color: OnemmColor.DARK_GRAY_COLOR),
              ),
            ],
          ),
        ),
        Container(height: 1.h, width: double.infinity, color: OnemmColor.LIGHT_GRAY_COLOR),
        ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: controller.themeController.likeThemeList.length,
            itemBuilder: (context, i) {
              return Obx(() {
                return InkWell(
                  onTap: () async {
                    await controller.themeController.getThemeItemsByOneList(controller.themeController.likeThemeList[i].themeId);
                    await controller.userController.getOtherUserInfo(controller.themeController.likeThemeList[i].themeOwnerId);

                    try {
                      if (controller.userController.uid != '' || controller.userController.uid != null) {
                        await controller.themeController.getLikeOneTheme(controller.userController.user.id, controller.themeController.likeThemeList[i].themeId);
                      }
                    } catch (e) {
                      print(e);
                    }

                    try {
                      await controller.userController.getFollowOne(controller.userController.user.id, controller.themeController.likeThemeList[i].themeOwnerId);
                      controller.userController.followOne.setFollowBool = true;
                    } catch (e) {
                      print(e);
                    }

                    Get.toNamed(AppRoutes.THEME_LIST);
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 10.w),
                    padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            ProfileImageBox(
                                controller.themeController.likeThemeList[i].themeOwnerId, controller.themeController.likeThemeList[i].s3, controller.themeController.likeThemeList[i].photoUrl),
                            SizedBox(width: 10.w),
                            // Text(controller.themeController.likeThemeList[i].userId),
                            Text(controller.themeController.likeThemeList[i].userName,
                                style: TextStyle(
                                  fontSize: FontSize.BASIC_TEXT.sp,
                                )),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  controller.themeController.likeThemeList[i].title,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: FontSize.BASIC_TEXT.sp,
                                    color: OnemmColor.COMMON_TEXT_COLOR,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 3),
                                Text(
                                  controller.themeController.likeThemeList[i].description,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                    color: OnemmColor.COMMON_TEXT_COLOR,
                                    fontSize: FontSize.BASIC_TEXT.sp,
                                  ),
                                ),
                              ],
                            ),
                            Icon(
                              Icons.keyboard_arrow_right,
                              color: OnemmColor.GRAY_COLOR_10,
                              size: 22.sp,
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                      ],
                    ),
                  ),
                );
              });
            }),
      ],
    );
  }
}
