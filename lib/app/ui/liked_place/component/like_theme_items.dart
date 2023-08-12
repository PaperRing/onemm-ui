import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:onemm/app/controller/store_controller.dart';
import 'package:onemm/app/ui/component/theme_store_image_box.dart';

import '../../common/style.dart';

class LikeThemeItems extends GetView<StoreController> {
  final int i;

  LikeThemeItems(this.i);

  @override
  Widget build(BuildContext context) {
    final _imageSize = MediaQuery.of(context).size.width / 3;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ThemeStoreImageBox(controller.themeController.likeThemeItems[i].storeId),
        SizedBox(height: 10.h),
        Column(
          children: [
            SizedBox(width: 40.w),
            Text(
              controller.themeController.likeThemeItems[i].storeName,
              style: TextStyle(fontSize: FontSize.BASIC_TEXT.sp),
            ),
            Row(
              children: [
                Icon(Icons.star, size: 15.sp, color: OnemmColor.ONE_MM_COLOR),
                Text(
                  "${controller.themeController.likeThemeItems[i].averageRating}",
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
