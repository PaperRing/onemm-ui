import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:onemm/app/controller/store_controller.dart';

import '../common/style.dart';

class CategoryLabel extends GetView<StoreController> {
  final String category;
  final String name;
  final double rating;

  CategoryLabel(this.category, this.name, this.rating);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
            padding: EdgeInsets.symmetric(vertical: 4.w, horizontal: 8.w),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: OnemmColor.ONE_MM_COLOR_2),
            child: Text(
              "${category}",
              style: TextStyle(fontSize: FontSize.MIDDLE_TEXT_11.sp, color: OnemmColor.test, fontWeight: FontWeight.w700),
            )),
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5.h),
              Text("${name}",
                  style: TextStyle(
                    fontSize: FontSize.MIDDLE_TEXT_13.sp,
                    fontWeight: FontWeight.w700,
                    // color: Colors.black87,
                  )),
              SizedBox(height: 3.h),
              Row(
                children: [
                  Icon(Icons.star, size: FontSize.BASIC_TEXT.sp, color: OnemmColor.ONE_MM_COLOR),
                  Text("${rating}", style: TextStyle(fontSize: FontSize.BASIC_SMALL_TEXT.sp)),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
