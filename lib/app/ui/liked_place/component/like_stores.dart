import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:onemm/app/routes/app_routes.dart';
import 'package:onemm/app/ui/nearby/store_detail_info/component/load_data.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../controller/store_controller.dart';
import '../../common/style.dart';
import '../../component/category_label.dart';
import '../../component/store_image_box.dart';

class LikeStores extends GetView<StoreController> {
  final int itemCount;
  final String title;

  const LikeStores(this.itemCount, this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 15.w, horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: TextStyle(fontSize: FontSize.BASIC_TEXT.sp, fontWeight: FontWeight.bold)),
                Text("+ ${controller.likeStoreController.likeStoreList.length}",
                    style: TextStyle(
                      fontSize: FontSize.BASIC_TEXT.sp,
                      color: OnemmColor.DARK_GRAY_COLOR,
                    )),
              ],
            ),
          ),
          Container(height: 1.h, width: double.infinity, color: OnemmColor.LIGHT_GRAY_COLOR),
          Container(
              padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 20.w),
              child: controller.likeStoreController.likeStoreList.length == 0
                  ? SizedBox(height: 30.h)
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: controller.likeStoreController.likeStoreList.length > 3 ? 3 : controller.likeStoreController.likeStoreList.length,
                      itemBuilder: (context, i) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () async {
                                await LoadData().loadData(controller.likeStoreController.likeStoreList[i].storeId, context);
                                await Get.toNamed(AppRoutes.STORE_DETAIL);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Row(
                                  children: [
                                    StoreImageBox(controller.likeStoreController.likeStoreList[i].storeId),
                                    SizedBox(width: 10.w),
                                    CategoryLabel(controller.likeStoreController.likeStoreList[i].category ?? "", controller.likeStoreController.likeStoreList[i].storeName,controller.likeStoreController.likeStoreList[i].averageRating == null ? 0 : controller.likeStoreController.likeStoreList[i].averageRating),
                                  ],
                                ),
                              ),
                            ),
                            controller.userController.user.id == controller.likeStoreController.likeStoreList[i].userId
                                ? ZoomTapAnimation(
                                    child: IconButton(
                                        icon: Image.asset('assets/icons/filled_heart.png', color: Colors.red, fit: BoxFit.cover, height: 16.h),
                                        onPressed: () async {
                                          await controller.likeStoreController.deleteLike(controller.userController.user.id, controller.likeStoreController.likeStoreList[i].storeId);
                                          await controller.likeStoreController.getLikeByUser(controller.userController.user.id);
                                        }))
                                : const SizedBox()
                          ],
                        );
                      },
                    )),
          controller.likeStoreController.likeStoreList.length > 3
              ? InkWell(
                  onTap: () {
                    Get.toNamed(AppRoutes.LIKED_STORES);
                    controller.likeStoreController.likeBool.value = true;
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "더보기",
                      style: TextStyle(color: OnemmColor.BLUE_TEXT_COLOR, fontSize: FontSize.BASIC_TEXT.sp),
                    ),
                  ))
              : const SizedBox()
        ],
      );
    });
  }
}
