import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:onemm/app/controller/store_controller.dart';
import 'package:onemm/app/ui/common/app_bar_back_icon_black.dart';

import '../../../routes/app_routes.dart';
import '../../common/style.dart';

class MyThemeListPage extends GetView<StoreController> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarBackButtonBlack(""),
      body: Obx(() {
        return controller.themeController.themeListByUser.length == 0
            ? Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                SizedBox(height: 100.h),
                Center(
                  child: Text(
                    "나만의 리스트를 만들어봐요 😊",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: FontSize.TITLE_MIDDLE_17.sp),
                  ),
                ),
              ])
            : ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: controller.themeController.themeListByUser.length,
                itemBuilder: (context, i) {
                  return InkWell(
                    onTap: () async {
                      try {
                        await controller.themeController.getThemeItemsByOneList(controller.themeController.themeListByUser[i].id);
                        await controller.themeController.getOneThemeList(controller.themeController.themeListByUser[i].id);
                        controller.themeController.noItems.value = false;
                        Get.toNamed(AppRoutes.MY_THEME_LIST_DETAIL);
                      } catch (e) {
                        controller.themeController.noItems.value = true;
                        await controller.themeController.getOneThemeList(controller.themeController.themeListByUser[i].id);
                        Get.toNamed(AppRoutes.MY_THEME_LIST_DETAIL);
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 10.w, top: 20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset('assets/icons/round_star.png', height: 17.h, color: OnemmColor.ONE_MM_COLOR),
                                  SizedBox(width: 10.w),
                                  Text(
                                    controller.themeController.themeListByUser[i].title,
                                    style: TextStyle(
                                      fontSize: FontSize.BASIC_TEXT.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.keyboard_arrow_right,
                                color: OnemmColor.GRAY_COLOR_10,
                                size: 20.h,
                              )
                            ],
                          ),
                          SizedBox(height: 10.h),
                        ],
                      ),
                    ),
                  );
                });
      }),
    );
  }
}
