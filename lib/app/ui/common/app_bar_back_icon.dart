import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:onemm/app/ui/common/style.dart';

class AppBarBackButton extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  AppBarBackButton(this.title);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 45.h,
      automaticallyImplyLeading: false,
      elevation: 0,
      titleSpacing: 0,
      backgroundColor: Colors.transparent,
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Image.asset(CommonIcon.BACK_BUTTON, height: 13.h, color: Colors.white),
          );
        },
      ),
      title: Text(
        title,
        style: TextStyle(fontSize: FontSize.BASIC_TEXT.sp),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(45.h);
}
