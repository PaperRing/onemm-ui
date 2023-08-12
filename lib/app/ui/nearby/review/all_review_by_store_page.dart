import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:onemm/app/controller/store_controller.dart';
import 'package:onemm/app/ui/component/review_image_box.dart';
import 'package:onemm/app/ui/nearby/store_detail_info/component/report_review.dart';

import '../../../routes/app_routes.dart';
import '../../common/review_app_bar.dart';
import '../../common/style.dart';
import '../../component/profile_image_box.dart';

class AllReviewByStorePage extends GetView<StoreController> {
  const AllReviewByStorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: ReviewAppBar(Get.arguments, controller.store.id),
        body: Obx(() {
          return ListView.builder(
              itemCount: controller.reviewController.reviewList.length,
              itemBuilder: (context, i) {
                return i == 0
                    ? Container(
                        padding: EdgeInsets.only(right: 20.w, left: 20.w, bottom: 10.w, top: 10.w),
                        color: OnemmColor.GRAY_COLOR_1,
                        child: buildColumn(i),
                      )
                    : Column(
                        children: [
                          Padding(
                            padding: CustomStyle.PADDING,
                            child: buildColumn(i),
                          ),
                          Container(
                            width: double.infinity,
                            height: 1.h,
                            color: OnemmColor.GRAY_COLOR_1,
                          )
                        ],
                      );
              });
        }));
  }

  Obx buildColumn(int i) {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10.h),
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
                      Text(controller.reviewController.reviewList[i].userName ?? '', style: TextStyle(fontSize: FontSize.BASIC_TEXT.sp)),
                      RatingBar(
                        initialRating: controller.reviewController.reviewList[i].rating ?? 0,
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
                      Text("${controller.reviewController.reviewList[i].createdAt}",
                          style: TextStyle(
                            fontSize: FontSize.BASIC_SMALL_TEXT.sp,
                            color: OnemmColor.DARK_GRAY_COLOR,
                          )),
                    ],
                  ),
                ],
              ),
              controller.userController.userId == controller.reviewController.reviewList[i].userId
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () async {
                            await controller.reviewController.getReviewById(controller.reviewController.reviewList[i].id);
                            Get.toNamed(AppRoutes.STORE_UPDATE_REVIEW);
                          },
                          child: Text(
                            "수정",
                            style: TextStyle(color: OnemmColor.DARK_GRAY_COLOR, fontSize: FontSize.MIDDLE_TEXT_13.sp),
                          ),
                        ),
                        Container(margin: EdgeInsets.symmetric(horizontal: 5.w), height: 12.h, width: 1.w, color: Colors.grey),
                        InkWell(
                          onTap: () async {
                            await controller.reviewController.deleteReview(controller.reviewController.reviewList[i].id!);
                            await controller.updateRating(controller.reviewController.reviewList[i].storeId!);
                            await controller.reviewController.getAllByStore(controller.reviewController.reviewList[i].storeId, controller.userController.user.id);
                            await controller.getStoreById(controller.reviewController.reviewList[i].storeId);
                            Get.toNamed(AppRoutes.STORE_ALL_REVIEW);
                          },
                          child: Text(
                            "삭제",
                            style: TextStyle(color: OnemmColor.DARK_GRAY_COLOR, fontSize: FontSize.MIDDLE_TEXT_13.sp),
                          ),
                        ),
                      ],
                    )
                  : ReportReview(controller.reviewController.reviewList[i].id),
            ],
          ),
          SizedBox(height: 5.h),
          ReviewImageBox(controller.reviewController.reviewList[i].storeId, controller.reviewController.reviewList[i].userId, controller.reviewController.reviewList[i].reviewS3),
          controller.reviewController.reviewList[i].content != ''
              ? Column(
                  children: [
                    SizedBox(height: 10.h),
                    Text(
                      "${controller.reviewController.reviewList[i].content}",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: FontSize.BASIC_TEXT.sp,
                      ),
                    ),
                    SizedBox(height: 15.h),
                  ],
                )
              : SizedBox(height: 15.h),
        ],
      );
    });
  }
}
