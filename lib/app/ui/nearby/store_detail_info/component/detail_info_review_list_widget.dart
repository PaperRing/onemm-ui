import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:onemm/app/ui/nearby/store_detail_info/component/report_review.dart';

import '../../../../controller/store_controller.dart';
import '../../../../routes/app_routes.dart';
import '../../../common/style.dart';
import '../../../component/profile_image_box.dart';
import '../../../component/review_image_box.dart';

class ReviewListWidget extends GetView<StoreController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListView.builder(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemCount: controller.reviewController.reviewList.length,
          itemBuilder: (context, i) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        ProfileImageBox(controller.reviewController.reviewList[i].userId, controller.reviewController.reviewList[i].s3, controller.reviewController.reviewList[i].photoUrl),
                        SizedBox(width: 7.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(controller.reviewController.reviewList[i].userName, style: TextStyle(fontSize: FontSize.BASIC_TEXT.sp)),
                            RatingBar(
                              initialRating: controller.reviewController.reviewList[i].rating ?? 0,
                              ignoreGestures: true,
                              minRating: 0,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemSize: 15.0,
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
                            Text(controller.reviewController.reviewList[i].createdAt, style: TextStyle(fontSize: FontSize.BASIC_TEXT.sp, color: OnemmColor.DARK_GRAY_COLOR)),
                          ],
                        ),
                      ],
                    ),
                    ReportReview(controller.reviewController.reviewList[i].id),
                  ],
                ),
                SizedBox(height: 10.h),
                InkWell(
                  onTap: () async {
                    await controller.reviewController.getOrderBySelectedReview(
                      controller.reviewController.reviewList[i].storeId,
                      controller.reviewController.reviewList[i].id,
                      controller.reviewController.reviewList[i].userId,
                    );
                    await Get.toNamed(AppRoutes.STORE_ALL_REVIEW, arguments: controller.store.name);
                  },
                  child: Column(
                    children: [
                      ReviewImageBox(controller.reviewController.reviewList[i].storeId, controller.reviewController.reviewList[i].userId, controller.reviewController.reviewList[i].reviewS3),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 10.w),
                        decoration: BoxDecoration(color: OnemmColor.GRAY_COLOR_2, borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Flexible(
                                child: RichText(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              text: TextSpan(
                                text: controller.reviewController.reviewList[i].content,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: FontSize.BASIC_TEXT.sp,
                                ),
                              ),
                            )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          });
    });
  }
}
