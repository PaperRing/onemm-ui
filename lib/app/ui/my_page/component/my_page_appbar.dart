import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:onemm/app/ui/my_page/component/login_view.dart';

class MyPageAppBar extends StatelessWidget with PreferredSizeWidget {
  const MyPageAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // toolbarHeight: 45.h,
      automaticallyImplyLeading: false,
      elevation: 0,
      titleSpacing: 0,
      backgroundColor: Colors.transparent,
      actions: [
        IconButton(
          onPressed: () {
            Get.to(LoginView());
          },
          icon: Icon(
            Icons.settings,
            size: 26.sp,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Size get preferredSize => Size.fromHeight(45.h);
}
