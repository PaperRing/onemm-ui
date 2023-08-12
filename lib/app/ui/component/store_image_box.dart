import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:onemm/app/controller/store_controller.dart';

class StoreImageBox extends GetView<StoreController> {
  final int storeId;

  const StoreImageBox(this.storeId);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: controller.reviewController.getLatestReviewImage(storeId),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey[100],
              ),
              height: 70.h,
              width: 80.w,
              child: Icon(
                Icons.camera_alt_outlined,
                size: 22.sp,
                color: Colors.black26,
              ),
            );
          } else if (!snapshot.hasError) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image(
                image: NetworkImage(
                    "https://onemm-bucket.s3.ap-northeast-2.amazonaws.com/review/${controller.reviewController.latestReviewImage.storeId}_${controller.reviewController.latestReviewImage.userId}"),
                fit: BoxFit.cover,
                width: 80.w,
                height: 70.h,
              ),
            );
          } else {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey[100],
              ),
              height: 70.h,
              width: 80.w,
              child: Icon(
                Icons.camera_alt_outlined,
                size: 22.sp,
                color: Colors.black26,
              ),
            );
          }
        });
  }
}
