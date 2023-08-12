import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:onemm/app/controller/store_controller.dart';
import 'package:onemm/app/routes/app_routes.dart';
import 'package:onemm/app/ui/common/style.dart';
import 'package:onemm/app/ui/theme_list/component/detail_info_dialog.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../../controller/dto/like_store_dto.dart';
import 'detail_info_icon.dart';

class DetailInfoTopWidget extends GetView<StoreController> {
  final RxBool like = false.obs;

  Row TitleCategory(List<Widget> categories, name) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(name, style: TextStyle(fontSize: FontSize.TITLE_MIDDLE_17.sp)),
        SizedBox(width: 5.w),
        Row(children: categories),
      ],
    );
  }

  Row AverageRating() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DetailInfoIcon(() {}, "assets/icons/star.png", 14.sp, OnemmColor.ONE_MM_COLOR),
        SizedBox(width: 5.w),
        Text("${controller.store.averageRating}", style: TextStyle(fontSize: FontSize.BASIC_TEXT.sp)),
      ],
    );
  }

  Container LikeShare(context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.w),
      child: Obx(() {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ZoomTapAnimation(
              child: IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  iconSize: 19.sp,
                  icon: controller.likeStoreController.likeBool.isTrue && controller.store.id == controller.likeStoreController.likeStore.storeId
                      ? Image.asset('assets/icons/filled_heart.png', color: Colors.red, fit: BoxFit.cover)
                      : Image.asset('assets/icons/love.png', color: Colors.black87, fit: BoxFit.cover),
                  onPressed: () async {
                    // 눌렀을때 로그인 되어있는지 확인
                    //TODO://
                    if (await controller.userController.user.id != '') {
                      controller.likeStoreController.likeBool.value = !controller.likeStoreController.likeBool.value;
                      LikeStoreDto likeValue = LikeStoreDto(controller.userController.user.id, controller.store.id, true);

                      controller.likeStoreController.likeBool.value
                          ? await controller.likeStoreController.addLike(likeValue.toJson())
                          : await controller.likeStoreController.deleteLike(controller.userController.user.id, controller.store.id);

                      await controller.likeStoreController.getLikeOneStore(controller.userController.user.id, controller.store.id);
                    } else {
                      Get.toNamed(AppRoutes.LOGIN);
                    }
                  }),
            ),
            ZoomTapAnimation(
              child: DetailInfoIcon(() async {
                if (await controller.userController.uid != '') {
                  await controller.themeController.getThemeListAllByUser(controller.userController.user.id);
                  DetailInfoDialog().first_dialog(context);
                } else {
                  Get.toNamed(AppRoutes.LOGIN);
                }
              }, "assets/icons/plus.png", 18.sp, Colors.black54),
            ),
          ],
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
