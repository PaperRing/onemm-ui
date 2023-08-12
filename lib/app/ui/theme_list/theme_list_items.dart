import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:onemm/app/controller/store_controller.dart';

import '../../routes/app_routes.dart';
import '../common/style.dart';
import '../component/profile_image_box.dart';

class ThemeListItems extends GetView<StoreController> {
  Color? color;

  ThemeListItems(this.color);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return controller.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: controller.themeController.themeList.length,
              itemBuilder: (context, i) {
                return InkWell(
                  onTap: () async {
                    await controller.themeController.getThemeItemsByOneList(controller.themeController.themeList[i].id);
                    await controller.userController.getOtherUserInfo(controller.themeController.themeList[i].userId);

                    try {
                      if (controller.userController.uid != '') {
                        await controller.themeController.getLikeOneTheme(controller.userController.user.id, controller.themeController.themeList[i].id);
                      }
                    } catch (e) {
                      print(e);
                    }

                    try {
                      await controller.userController.getFollowOne(controller.userController.user.id, controller.themeController.themeList[i].userId);
                      controller.userController.followBool.value = true;
                      print(controller.userController.themeFollowBool.value);
                    } catch (e) {
                      controller.userController.followBool.value = false;
                      print(e);
                    }

                    Get.toNamed(AppRoutes.THEME_LIST);
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 5.w, top: 10.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                ProfileImageBox(controller.themeController.themeList[i].userId, controller.themeController.themeList[i].s3, controller.themeController.themeList[i].photoUrl),
                                SizedBox(width: 10.w),
                                Text(controller.themeController.themeList[i].userName, style: TextStyle(fontSize: FontSize.BASIC_TEXT.sp, fontWeight: FontWeight.w700)),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    controller.themeController.themeList[i].title,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: FontSize.BASIC_TEXT.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    controller.themeController.themeList[i].description,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                      color: OnemmColor.COMMON_TEXT_COLOR,
                                      fontSize: FontSize.BASIC_TEXT.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Icon(
                                Icons.keyboard_arrow_right,
                                color: OnemmColor.GRAY_COLOR_10,
                                size: 22.sp,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                      ],
                    ),
                  ),
                );
              });
    });
  }
}
