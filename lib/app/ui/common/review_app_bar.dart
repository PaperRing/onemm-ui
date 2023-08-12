import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:onemm/app/controller/store_controller.dart';
import 'package:onemm/app/ui/common/style.dart';

class ReviewAppBar extends GetView<StoreController> with PreferredSizeWidget {
  final String title;
  final int storeId;

  ReviewAppBar(this.title, this.storeId);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 50.h,
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Colors.white,
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            onPressed: () async {
              controller.imageController.deleteImage();
              controller.imageController.s3DeleteBool.value = false;
              Get.back();
            },
            icon: Image.asset(CommonIcon.BACK_BUTTON, height: 16.h, color: Colors.black),
          );
        },
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.black87, fontSize: FontSize.BASIC_TEXT.sp),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(50.h);
}
