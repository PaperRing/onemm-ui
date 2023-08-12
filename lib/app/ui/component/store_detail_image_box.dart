import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:onemm/app/controller/store_controller.dart';

class StoreDetailImageBox extends GetView<StoreController> {
  final int storeId;

  StoreDetailImageBox(this.storeId);

  @override
  Widget build(BuildContext context) {
    final _imageSize = MediaQuery.of(context).size.width / 3;

    return FutureBuilder(
        future: controller.reviewController.getLatestReviewImage(storeId),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              height: 180.h,
              width: double.infinity,
              color: Colors.grey[200],
              child: Icon(
                Icons.camera_alt_outlined,
                size: 22.sp,
                color: Colors.black26,
              ),
            );
          } else if (!snapshot.hasError) {
            return Container(
              height: 180.h,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      "https://onemm-bucket.s3.ap-northeast-2.amazonaws.com/review/${controller.reviewController.latestReviewImage.storeId}_${controller.reviewController.latestReviewImage.userId}"),
                  fit: BoxFit.fitWidth,
                ),
              ),
            );
          } else {
            return Container(
              height: 180.h,
              width: double.infinity,
              color: Colors.grey[200],
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
