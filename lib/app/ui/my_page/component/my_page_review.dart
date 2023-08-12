import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:onemm/app/controller/store_controller.dart';

import '../../common/app_bar_back_icon_black.dart';
import '../../common/style.dart';
import '../../nearby/review/my_page_update_review.dart';

class MyReviewPage extends GetView<StoreController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarBackButtonBlack(""),
      body: controller.reviewController.myReviewList.length == 0
          ? Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
              SizedBox(height: 100.h),
              Center(
                child: Text(
                  "리뷰를 남겨보는건 어때요? 😊",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: FontSize.TITLE_MIDDLE_17.sp),
                ),
              ),
            ])
          : ListView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: controller.reviewController.myReviewList.length,
              itemBuilder: (context, i) {
                return Obx(() {
                  return Padding(padding: EdgeInsets.only(left: 20.w, right: 20.w), child: buildColumn(i, context));
                });
              }),
    );
  }

  Column buildColumn(int i, context) {
    final _imageSize = MediaQuery.of(context).size.width / 2.5;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(controller.reviewController.myReviewList[i].storeName ?? "", style: TextStyle(fontSize: FontSize.BASIC_TEXT.sp, fontWeight: FontWeight.bold)),
                    RatingBar(
                      initialRating: controller.reviewController.myReviewList[i].rating ?? 0,
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
                    Text("${controller.reviewController.myReviewList[i].createdAt}", style: TextStyle(fontSize: FontSize.BASIC_SMALL_TEXT.sp, color: OnemmColor.DARK_GRAY_COLOR))
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () async {
                    await controller.reviewController.getReviewById(controller.reviewController.myReviewList[i].id);
                    await controller.getStoreById(controller.reviewController.myReviewList[i].storeId);

                    Get.to(MyUpdateReviewPage());
                  },
                  child: Text(
                    "수정",
                    style: TextStyle(color: OnemmColor.DARK_GRAY_COLOR, fontSize: FontSize.BASIC_TEXT.sp),
                  ),
                ),
                Container(margin: EdgeInsets.symmetric(horizontal: 5.w), height: 15.h, width: 1.w, color: Colors.grey),
                InkWell(
                  onTap: () async {
                    await controller.reviewController.deleteReview(controller.reviewController.myReviewList[i].id!);
                    await controller.updateRating(controller.reviewController.myReviewList[i].storeId!);
                    await controller.reviewController.getReviewByUser(controller.reviewController.myReviewList[i].userId);
                  },
                  child: Text(
                    "삭제",
                    style: TextStyle(color: OnemmColor.DARK_GRAY_COLOR, fontSize: FontSize.BASIC_TEXT.sp),
                  ),
                ),
              ],
            )
          ],
        ),
        SizedBox(height: 5.h),
        controller.reviewController.myReviewList[i].reviewS3
            ? Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  height: _imageSize,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(
                          "https://onemm-bucket.s3.ap-northeast-2.amazonaws.com/review/${controller.reviewController.myReviewList[i].storeId}_${controller.reviewController.myReviewList[i].userId}"),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              )
            : SizedBox(),
        SizedBox(height: 5.h),
        controller.reviewController.myReviewList[i].content != ''
            ? Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 10.w),
                    decoration: BoxDecoration(color: OnemmColor.GRAY_COLOR_1, borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(
                            child: RichText(
                          text: TextSpan(
                            text: controller.reviewController.myReviewList[i].content,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: FontSize.BASIC_TEXT.sp,
                            ),
                          ),
                        )),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.w),
                ],
              )
            : SizedBox(height: 10.w)
      ],
    );
  }
}
