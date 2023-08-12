import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:onemm/app/ui/common/style.dart';
import 'package:onemm/app/ui/other_user/block_user_button.dart';

import '../../controller/user_controller.dart';

class AppBarBackWithBlock extends GetView<UserController> implements PreferredSizeWidget {
  late String text;

  AppBarBackWithBlock(this.text);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 45.h,
      automaticallyImplyLeading: false,
      elevation: 0,
      titleSpacing: 0,
      backgroundColor: Colors.transparent,
      title: Text(
        text,
        style: TextStyle(color: Colors.black87, fontSize: FontSize.BASIC_TEXT.sp),
      ),
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Image.asset(CommonIcon.BACK_BUTTON, height: 16.h, color: Colors.black),
          );
        },
      ),
      actions: [Padding(padding: EdgeInsets.all(15.w), child: BlockUserButton())],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(45.h);
}
