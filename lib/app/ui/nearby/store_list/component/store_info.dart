import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:onemm/app/controller/store_controller.dart';

import '../../../common/style.dart';

class StoreInfo extends GetView<StoreController> {
  final int i;

  StoreInfo(this.i);

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
                    Text(controller.storeDto[i].name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: OnemmColor.BLUE_TEXT_COLOR,
                          fontSize: FontSize.BASIC_TEXT.sp,
                        )),
                    SizedBox(width: 10.w),
                    Text("${controller.storeDto[i].dong}", style: TextStyle(fontSize: FontSize.MIDDLE_TEXT_13.sp, color: OnemmColor.DARK_GRAY_COLOR)),
                    Container(margin: EdgeInsets.symmetric(horizontal: 7), height: 10.h, width: 1.w, color: Colors.grey),
                    Text(controller.storeDto[i].category ?? "", style: TextStyle(fontSize: FontSize.MIDDLE_TEXT_13.sp, color: OnemmColor.DARK_GRAY_COLOR)),
                  ],
                ),

                SizedBox(height: 4.h),
                controller.storeDto[i].count != null
                    ? Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: OnemmColor.ONE_MM_COLOR,
                            size: 18.sp,
                          ),
                          Text("${controller.storeDto[i].averageRating}", style: TextStyle(fontSize: FontSize.MIDDLE_TEXT_13.sp)),
                          SizedBox(width: 10.w),
                          Text("리뷰 ${controller.storeDto[i].count ?? 0}", style: TextStyle(fontSize: FontSize.MIDDLE_TEXT_13.sp, color: OnemmColor.DARK_GRAY_COLOR)),
                        ],
                      )
                    : Container(height: 5.h),
                // SizedBox(height: 15.h)
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [],
          )
        ],
      );
    });
  }
}
