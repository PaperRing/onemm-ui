import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:onemm/app/controller/store_controller.dart';
import 'package:onemm/app/routes/app_routes.dart';

import '../../common/style.dart';
import '../../component/theme_store_image_box.dart';
import '../../nearby/store_detail_info/component/load_data.dart';

class ThemeListImage extends GetView<StoreController> {
  final int i;

  ThemeListImage(this.i);

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () async {
            await LoadData().loadData(controller.themeController.themeItems[i].storeId, context);
            await Get.toNamed(AppRoutes.STORE_DETAIL);
          },
          child: ThemeStoreImageBox(controller.themeController.themeItems[i].storeId),
        ),
        SizedBox(height: 10.h),
        Column(
          children: [
            SizedBox(width: 40.w),
            Text(
              controller.themeController.themeItems[i].storeName,
              style: TextStyle(fontSize: FontSize.BASIC_TEXT.sp),
            ),
            Row(
              children: [
                Icon(Icons.star, size: 15.sp, color: OnemmColor.ONE_MM_COLOR),
                Text(
                  "${controller.themeController.themeItems[i].averageRating}",
                  style: TextStyle(fontSize: FontSize.BASIC_TEXT.sp),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
