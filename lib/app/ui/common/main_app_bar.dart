import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:onemm/app/controller/store_controller.dart';
import 'package:onemm/app/routes/app_routes.dart';
import 'package:onemm/app/ui/common/style.dart';
import 'package:onemm/app/ui/component/common_icon_button.dart';

import '../component/location_button.dart';

class MainAppbar extends GetView<StoreController> implements PreferredSizeWidget {
  const MainAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 45.h,
      automaticallyImplyLeading: false,
      backgroundColor: OnemmColor.BACKGROUND_COLOR,
      elevation: 0,
      titleSpacing: 20.w,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
              flex: 1,
              child: LocationButton(
                onPress: () {},
                fontSize: FontSize.BASIC_TEXT.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              )),
          Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CommonIconButton('assets/icons/search.png', Colors.black, 18.h, () async {
                    controller.currentIndex.value = 3;
                    if (controller.userController.uid != '') {
                      try {
                        await controller.searchController.getSearchRecord(controller.userController.user.id);
                      } catch (e) {
                        print(e);
                      }
                    }
                    Get.toNamed(AppRoutes.SEARCH);
                  }),
                  SizedBox(width: 10.w),
                ],
              )),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(45.h);
}
