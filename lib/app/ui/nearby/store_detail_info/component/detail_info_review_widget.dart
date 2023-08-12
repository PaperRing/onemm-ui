import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:onemm/app/routes/app_routes.dart';

import '../../../../controller/store_controller.dart';
import '../../../common/style.dart';
import 'detail_box.dart';
import 'detail_info_review_list_widget.dart';

class DetailInfoReviewWidget extends GetView<StoreController> {
  AskReview() {
    return Obx(() {
      return DetailBox([
        controller.userController.user.name != ''
            ? InkWell(
                onTap: () {
                  controller.imageController.deleteImage();
                  Get.toNamed(AppRoutes.STORE_SAVE_REVIEW, arguments: controller.store.name);
                },
                child: Column(
                  children: [
                    SizedBox(height: 10.h),
                    controller.userController.user.s3 == true
                        ? Container(
                            width: 45.w,
                            height: 45.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage("https://onemm-bucket.s3.ap-northeast-2.amazonaws.com/profile/${controller.userController.user.id}"),
                                fit: BoxFit.fill,
                              ),
                            ),
                          )
                        : Container(
                            width: 50.w,
                            height: 50.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(image: NetworkImage(controller.userController.user.photoUrl), fit: BoxFit.cover),
                            ),
                          ),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("${controller.userController.user.name!}님 ", style: TextStyle(fontSize: FontSize.TITLE_MIDDLE_16.sp, color: Colors.blue)),
                        Text("후기를 남겨주세요!", style: TextStyle(fontSize: FontSize.TITLE_MIDDLE_16.sp)),
                      ],
                    ),
                    SizedBox(height: 5.h),
                    RatingBar(
                      initialRating: 0,
                      ignoreGestures: true,
                      minRating: 0,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 30.0,
                      ratingWidget: RatingWidget(
                        full: Image.asset('assets/icons/star.png'),
                        half: Image.asset('assets/icons/rating.png'),
                        empty: Image.asset('assets/icons/star.png', color: OnemmColor.LIGHT_GRAY_COLOR),
                      ),
                      itemPadding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 4.w),
                      glow: false,
                      updateOnDrag: true,
                      onRatingUpdate: (double value) {},
                    ),
                    SizedBox(height: 10.h),
                  ],
                ),
              )
            : InkWell(
                onTap: () {
                  Get.toNamed(AppRoutes.LOGIN);
                },
                child: Column(
                  children: [
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/icons/star.png', color: OnemmColor.GRAY_COLOR_3, width: 30.w, height: 30.h, fit: BoxFit.fill),
                        Image.asset('assets/icons/star.png', color: OnemmColor.GRAY_COLOR_3, width: 30.w, height: 30.h, fit: BoxFit.fill),
                        Image.asset('assets/icons/star.png', color: OnemmColor.GRAY_COLOR_3, width: 30.w, height: 30.h, fit: BoxFit.fill),
                        Image.asset('assets/icons/star.png', color: OnemmColor.GRAY_COLOR_3, width: 30.w, height: 30.h, fit: BoxFit.fill),
                        Image.asset('assets/icons/star.png', color: OnemmColor.GRAY_COLOR_3, width: 30.w, height: 30.h, fit: BoxFit.fill),
                      ],
                    ),
                    SizedBox(height: 15.h),
                    Text("로그인 하고 후기를 남겨주세요!", style: TextStyle(fontSize: FontSize.TITLE_MIDDLE_16.sp)),
                    SizedBox(height: 10.h),
                  ],
                ),
              )
      ]);
    });
  }

  UserReviewTotal() {
    return DetailBox([
      SizedBox(height: 10.h),
      Obx(() {
        return Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text("${controller.store.averageRating} ", style: TextStyle(fontSize: FontSize.BASIC_TEXT.sp)),
                    RatingBar(
                      initialRating: controller.store.averageRating,
                      ignoreGestures: true,
                      minRating: 0,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 18.0,
                      ratingWidget: RatingWidget(
                        full: Image.asset('assets/icons/star.png'),
                        half: Image.asset('assets/icons/rating.png'),
                        empty: Image.asset('assets/icons/star.png', color: OnemmColor.LIGHT_GRAY_COLOR),
                      ),
                      itemPadding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 4.w),
                      glow: false,
                      updateOnDrag: true,
                      onRatingUpdate: (double value) {},
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.people_alt, size: 20, color: OnemmColor.GRAY_COLOR_8),
                    SizedBox(width: 5.w),
                    Text("${controller.store.count}", style: TextStyle(fontSize: 14.sp, color: OnemmColor.COMMON_TEXT_COLOR)),
                  ],
                ),
              ],
            ),
            SizedBox(height: 5.h),
            ReviewListWidget()
          ],
        );
      }),
      SizedBox(height: 10.h)
    ]);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
