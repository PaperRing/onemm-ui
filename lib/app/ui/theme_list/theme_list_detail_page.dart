import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:onemm/app/controller/store_controller.dart';
import 'package:onemm/app/model/like_theme.dart';
import 'package:onemm/app/ui/component/store_image_box.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../routes/app_routes.dart';
import '../common/app_bar_back_with_block.dart';
import '../common/style.dart';
import '../component/profile_image_box.dart';
import '../nearby/store_detail_info/component/load_data.dart';
import '../other_user/follow_button.dart';

class ThemeListDetailPage extends GetView<StoreController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBackWithBlock(""),
      body: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: [
          Obx(() {
            return Column(
              children: [
                UserProfile(),
                Container(width: double.infinity, height: 1.h, color: OnemmColor.GRAY_COLOR_1),
                SizedBox(height: 20.h),
                Container(
                  padding: CustomStyle.PADDING,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Expanded(child: ThemeTitle()), LikeShare()],
                  ),
                ),
                SizedBox(height: 15.h),
                Container(width: double.infinity, height: 4.h, color: OnemmColor.GRAY_COLOR_1),
                SizedBox(height: 20.h),
                StoreList()
              ],
            );
          }),
        ],
      ),
    );
  }

  ListView StoreList() {
    return ListView.builder(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemCount: controller.themeController.themeItemsByOneList.length,
        itemBuilder: (context, i) {
          return Obx(() {
            return Container(
              padding: EdgeInsets.only(left: 20.w, right: 20.w),
              child: Column(
                children: [
                  InkWell(
                    onTap: () async {
                      await LoadData().loadData(controller.themeController.themeItemsByOneList[i].storeId, context);
                      await Get.toNamed(AppRoutes.STORE_DETAIL);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 10.w),
                      child: Row(
                        children: [
                          StoreImageBox(controller.themeController.themeItemsByOneList[i].storeId),
                          SizedBox(width: 10.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 5.h),
                                    Text("${controller.themeController.themeItemsByOneList[i].storeName}",
                                        style: TextStyle(
                                          fontSize: FontSize.BASIC_TEXT.sp,
                                          fontWeight: FontWeight.w700,
                                        )),
                                    SizedBox(height: 3.h),
                                    Row(
                                      children: [
                                        Icon(Icons.star, size: FontSize.TITLE_MIDDLE_16.sp, color: OnemmColor.ONE_MM_COLOR),
                                        Text("${controller.themeController.themeItemsByOneList[i].averageRating == null ? 0 : controller.hotPlace[i].averageRating}",
                                            style: TextStyle(fontSize: FontSize.BASIC_SMALL_TEXT.sp)),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          });
        });
  }

  Container LikeShare() {
    return Container(
      padding: EdgeInsets.only(left: 10),
      child: Obx(() {
        return controller.themeController.themeItemsByOneList[0].userId == controller.userController.user.id
            ? SizedBox()
            : ZoomTapAnimation(
                child: IconButton(
                    icon: controller.themeController.likeBool.isTrue || controller.themeController.themeItemsByOneList[0].themeId == controller.themeController.likeTheme.themeId
                        ? Image.asset('assets/icons/filled_heart.png', color: Colors.red, fit: BoxFit.cover, height: 21.h)
                        : Image.asset('assets/icons/heart.png', color: Colors.black87, fit: BoxFit.cover, height: 21.h),
                    onPressed: () async {
                      // 눌렀을때 로그인 되어있는지 확인
                      if (await controller.userController.uid == '') {
                        Get.toNamed(AppRoutes.LOGIN);
                      } else {
                        controller.themeController.likeBool.value = !controller.themeController.likeBool.value;
                        LikeTheme likeTheme = LikeTheme(controller.userController.user.id, controller.themeController.themeItemsByOneList[0].themeId, true);

                        controller.themeController.likeBool.value
                            ? await controller.themeController.addThemeListLike(likeTheme.toJson())
                            : await controller.themeController.deleteThemeListLike(controller.userController.user.id, controller.themeController.themeItemsByOneList[0].themeId);
                      }
                    }),
              );
      }),
    );
  }

  Column ThemeTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          overflow: TextOverflow.ellipsis,
          maxLines: 5,
          strutStyle: StrutStyle(fontSize: FontSize.TITLE_18.sp, fontWeight: FontWeight.bold),
          text: TextSpan(
            text: "${controller.themeController.themeItemsByOneList[0].title}",
            style: TextStyle(fontSize: FontSize.TITLE_MIDDLE_16.sp, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        const SizedBox(height: 6),
        RichText(
          overflow: TextOverflow.ellipsis,
          maxLines: 5,
          strutStyle: StrutStyle(fontSize: FontSize.BASIC_TEXT.sp),
          text: TextSpan(
            text: "${controller.themeController.themeItemsByOneList[0].description}",
            style: TextStyle(fontSize: FontSize.BASIC_TEXT.sp, color: Colors.black),
          ),
        ),
      ],
    );
  }

  Container UserProfile() {
    return Container(
      padding: CustomStyle.PADDING,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ProfileImageBox(controller.userController.otherUserInfo.id, controller.userController.otherUserInfo.s3, controller.userController.otherUserInfo.photoUrl ?? ""),
              SizedBox(width: 10.w),
              Text(
                "${controller.userController.otherUserInfo.name}",
                style: TextStyle(fontSize: FontSize.TITLE_MIDDLE_16.sp, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          FollowButton(),
        ],
      ),
    );
  }

  Size get preferredSize => Size.fromHeight(45.h);
}
