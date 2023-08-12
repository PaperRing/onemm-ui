import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:onemm/app/controller/store_controller.dart';

class ThemeStoreImageBox extends GetView<StoreController> {
  final int storeId;

  ThemeStoreImageBox(this.storeId);

  @override
  Widget build(BuildContext context) {
    final _imageSize = MediaQuery.of(context).size.width / 3;

    return FutureBuilder(
        future: controller.reviewController.getLatestReviewImage(storeId),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              height: _imageSize,
              width: _imageSize,
              color: Colors.grey[350],
              child: Icon(
                Icons.camera_alt_outlined,
                size: 22.sp,
                color: Colors.black26,
              ),
            );
          } else if (!snapshot.hasError) {
            return Container(
              height: _imageSize,
              width: _imageSize,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      "https://onemm-bucket.s3.ap-northeast-2.amazonaws.com/review/${controller.reviewController.latestReviewImage.storeId}_${controller.reviewController.latestReviewImage.userId}"),
                  fit: BoxFit.fill,
                ),
              ),
            );
          } else {
            return Container(
              height: _imageSize,
              width: _imageSize,
              color: Colors.grey[350],
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
