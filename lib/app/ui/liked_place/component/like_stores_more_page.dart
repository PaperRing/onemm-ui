import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:onemm/app/ui/common/app_bar_back_icon_black.dart';
import 'package:onemm/app/ui/component/store_image_box.dart';
import 'package:onemm/app/ui/nearby/store_detail_info/component/load_data.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../controller/store_controller.dart';
import '../../../routes/app_routes.dart';
import '../../component/category_label.dart';

class LikeStoreMorePage extends GetView<StoreController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBackButtonBlack("찜한장소"),
      body: ListView.builder(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemCount: controller.likeStoreController.likeStoreList.length,
          itemBuilder: (context, i) {
            return Obx(() {
              return Container(
                padding: EdgeInsets.only(left: 20.w, right: 20.w),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () async {
                        await LoadData().loadData(controller.likeStoreController.likeStoreList[i].storeId, context);
                        await Get.toNamed(AppRoutes.STORE_DETAIL);
                      },
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 10.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                StoreImageBox(controller.likeStoreController.likeStoreList[i].storeId),
                                SizedBox(width: 10.w),
                                CategoryLabel(controller.likeStoreController.likeStoreList[i].category ?? "", controller.likeStoreController.likeStoreList[i].storeName,
                                    controller.likeStoreController.likeStoreList[i].averageRating == null ? 0 : controller.likeStoreController.likeStoreList[i].averageRating),
                              ],
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
                        ),
                      ),
                    ),
                  ],
                ),
              );
            });
          }),
    );
  }
}
