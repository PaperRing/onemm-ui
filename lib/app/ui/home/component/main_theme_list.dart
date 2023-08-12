import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../../controller/store_controller.dart';
import '../../common/style.dart';
import '../../component/text_button.dart';
import '../../theme_list/theme_list_items.dart';

class MainThemeList extends GetView<StoreController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: CustomStyle.PADDING,
      child: Container(
        decoration: CustomStyle.CONTAINER_CIRCLE,
        padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 20.w, bottom: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MainTextButton("유저들의 테마리스트 ✨"),
            SizedBox(height: 15.h),
            ThemeListItems(null),
          ],
        ),
      ),
    );
  }
}
