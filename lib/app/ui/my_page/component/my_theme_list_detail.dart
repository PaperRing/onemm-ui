import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:onemm/app/controller/store_controller.dart';

import '../../../controller/dto/theme_list_dto.dart';
import '../../../routes/app_routes.dart';
import '../../common/app_bar_back_icon_black.dart';
import '../../common/style.dart';
import '../../component/store_image_box.dart';
import '../../nearby/store_detail_info/component/load_data.dart';

class MyThemeListDetailPage extends GetView<StoreController> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBarBackButtonBlack(""),
        body: ListView(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          children: [
            Obx(() {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: CustomStyle.PADDING,
                    child: controller.themeController.editBool.value
                        ? Column(
                            children: [
                              ThemeTitle(),
                              SizedBox(height: 15.h),
                              EditButtonBox(),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(flex: 4, child: ThemeTitle()),
                              Flexible(flex: 1, child: ButtonBox()),
                            ],
                          ),
                  ),
                  Container(width: double.infinity, height: 1.h, color: OnemmColor.GRAY_COLOR_1),
                  SizedBox(height: 20.h),
                  controller.themeController.noItems.value ? SizedBox() : StoreList(),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

  Column StoreList() {
    return Column(
      children: [
        ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: controller.themeController.themeItemsByOneList.length,
            itemBuilder: (context, i) {
              return Obx(() {
                return ListTile(
                    title: InkWell(
                  onTap: () async {
                    await LoadData().loadData(controller.themeController.themeItemsByOneList[i].storeId, context);
                    await Get.toNamed(AppRoutes.STORE_DETAIL);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 10.w, left: 10.w, right: 10.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
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
                                      Text("${controller.themeController.themeItemsByOneList[i].storeName}", style: TextStyle(fontSize: FontSize.BASIC_TEXT.sp, fontWeight: FontWeight.w700)),
                                      SizedBox(height: 3.h),
                                      Row(
                                        children: [
                                          Icon(Icons.star, size: 17.sp, color: OnemmColor.ONE_MM_COLOR),
                                          Text("${controller.themeController.themeItemsByOneList[i].averageRating == null ? 0 : controller.hotPlace[i].averageRating}",
                                              style: TextStyle(fontSize: FontSize.MIDDLE_TEXT_13.sp)),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () async {
                            var themeId = controller.themeController.themeItemsByOneList[i].themeId;
                            var storeId = controller.themeController.themeItemsByOneList[i].storeId;
                            await controller.themeController.deleteThemeItem(themeId, storeId);

                            try {
                              await controller.themeController.getThemeItemsByOneList(themeId);
                            } catch (e) {
                              controller.themeController.noItems.value = true;
                              Get.toNamed(AppRoutes.MY_THEME_LIST_DETAIL);
                            }
                          },
                          child: Icon(Icons.close, size: 18.sp, color: OnemmColor.DARK_GRAY_COLOR),
                        )
                      ],
                    ),
                  ),
                ));
              });
            }),
      ],
    );
  }

  Obx ThemeTitle() {
    return Obx(() {
      if (controller.themeController.editBool.value) {
        return Form(
          key: this._formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.only(top: 8, bottom: 8, left: 10, right: 10),
                  filled: true,
                  fillColor: OnemmColor.GRAY_COLOR_1,
                  errorStyle: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
                initialValue: controller.themeController.myThemeList.title,
                style: TextStyle(
                  decoration: TextDecoration.none,
                  fontSize: FontSize.BASIC_TEXT.sp,
                ),
                onSaved: (val) async {
                  this.title = val!;
                },
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return '테마명을 한글자 이상 입력해주세요.';
                  }
                },
              ),
              SizedBox(height: 10.h),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.only(top: 8, bottom: 8, left: 10, right: 10),
                  filled: true,
                  fillColor: OnemmColor.GRAY_COLOR_1,
                  errorStyle: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
                initialValue: controller.themeController.myThemeList.description,
                style: TextStyle(
                  decoration: TextDecoration.none,
                  fontSize: FontSize.BASIC_TEXT.sp,
                ),
                onSaved: (val) async {
                  this.description = val!;
                },
              ),
            ],
          ),
        );
      } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${controller.themeController.myThemeList.title}",
              style: TextStyle(fontSize: FontSize.TITLE_MIDDLE_17.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.h),
            Text(
              "${controller.themeController.myThemeList.description}",
              style: TextStyle(fontSize: FontSize.BASIC_TEXT.sp),
            ),
          ],
        );
      }
    });
  }

  EditButtonBox() {
    return Row(
      children: [
        InkWell(
            onTap: () async {
              this._formKey.currentState?.save();

              ThemeListDto updateTheme = ThemeListDto(this.title, this.description);
              await controller.themeController.updateThemeList(controller.themeController.themeItemsByOneList[0].themeId, updateTheme.toJson());
              await controller.themeController.getOneThemeList(controller.themeController.themeItemsByOneList[0].themeId);

              controller.themeController.editBool.value = false;
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 18.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.w),
                color: OnemmColor.ONE_MM_COLOR,
              ),
              child: Text(
                "저장",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: FontSize.BASIC_TEXT.sp, color: Colors.white, fontWeight: FontWeight.w500),
              ),
            )),
        SizedBox(width: 10.w),
        InkWell(
            onTap: () async {
              controller.themeController.editBool.value = false;
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 18.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.w),
                color: OnemmColor.ONE_MM_COLOR,
              ),
              child: Text(
                "취소",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: FontSize.BASIC_TEXT.sp, color: Colors.white, fontWeight: FontWeight.w500),
              ),
            )),
      ],
    );
  }

  ButtonBox() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
            onTap: () async {
              await controller.themeController.deleteThemeList(controller.themeController.myThemeList.id);
              await controller.themeController.getThemeListAllByUser(controller.userController.user.id);
              Get.back();
            },
            child: Icon(Icons.delete, size: 23.sp, color: OnemmColor.DARK_GRAY_COLOR)),
        SizedBox(width: 8.w),
        GestureDetector(
            onTap: () {
              controller.themeController.editBool.value = true;
              print(controller.themeController.editBool.value);
            },
            child: Icon(Icons.edit, size: 23.sp, color: OnemmColor.DARK_GRAY_COLOR)),
      ],
    );
  }
}
