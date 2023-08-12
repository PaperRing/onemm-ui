import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:onemm/app/controller/store_controller.dart';

import '../../common/style.dart';

class SearchStoreInfo extends GetView<StoreController> {
  final int i;

  const SearchStoreInfo(this.i, {super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(controller.searchList[i].name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: FontSize.TITLE_MIDDLE_17.sp, color: OnemmColor.BLUE_TEXT_COLOR)),
                    SizedBox(width: 10.w),
                    Text("${controller.searchList[i].dong}", style: TextStyle(fontSize: FontSize.BASIC_TEXT.sp, color: OnemmColor.DARK_GRAY_COLOR)),
                    Container(margin: const EdgeInsets.symmetric(horizontal: 7), height: 14.h, width: 1.w, color: Colors.grey),
                    Text(controller.searchList[i].category ?? "", style: TextStyle(fontSize: FontSize.BASIC_TEXT.sp, color: OnemmColor.DARK_GRAY_COLOR)),
                  ],
                ),

                SizedBox(height: 4.h),
                controller.searchList[i].count != null
                    ? Row(
                        children: [
                          const Icon(Icons.star, color: OnemmColor.ONE_MM_COLOR),
                          Text("${controller.searchList[i].averageRating}", style: TextStyle(fontSize: FontSize.BASIC_TEXT.sp)),
                          SizedBox(width: 10.w),
                          Text("리뷰 ${controller.searchList[i].count ?? 0}", style: TextStyle(fontSize: FontSize.MIDDLE_TEXT_13.sp, color: OnemmColor.DARK_GRAY_COLOR)),
                        ],
                      )
                    : Container(height: 5.h),
                // SizedBox(height: 15.h)
              ],
            ),
          ),
        ],
      );
    });
  }
}
