import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:onemm/app/controller/store_controller.dart';
import 'package:onemm/app/ui/component/save_button.dart';

import '../../../controller/dto/review_dto.dart';
import '../../common/review_app_bar.dart';
import '../../common/style.dart';
import '../../component/image_upload_sheet.dart';
import 'component/review_image_box.dart';

class UpdateReviewPage extends GetView<StoreController> {
  final _formKey = GlobalKey<FormState>();
  double rating = -1;
  String content = '';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: ReviewAppBar(controller.store.name, controller.store.id),
        body: SingleChildScrollView(
          child: Form(
            key: this._formKey,
            child: Padding(
              padding: CustomStyle.PADDING,
              child: Obx(() {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 25.h),
                    build_rating(),
                    SizedBox(height: 20.h),
                    build_content(),
                    SizedBox(height: 30.h),
                    controller.reviewController.reviewDto.s3 == true
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              UpdateReviewImageBox(controller.store.id, controller.userController.user.id),
                            ],
                          )
                        : const SizedBox(),
                    ImageUploadSheetButton(),
                    SizedBox(height: 15.h),
                    SaveButton(() async {
                      _formKey.currentState?.save();

                      if (controller.imageController.selectedImagePath!.value != '') {
                        var url = await controller.imageController.getS3PreSignedUrl("review", "${controller.store.id}_${controller.userController.user.id}");
                        File image = File(controller.imageController.selectedImagePath!.value);
                        await controller.imageController.putS3(url, image);
                        imageCache.clear();
                        imageCache.clearLiveImages();
                      }

                      print(controller.reviewController.imageController.imageBool.value);

                      ReviewDto newReview = ReviewDto(controller.store.id, controller.userController.user.id, content, rating == -1 ? controller.reviewController.reviewDto.rating : rating,
                          controller.imageController.imageBool.value);

                      await controller.reviewController.updateReview(newReview.toJson(), controller.reviewController.reviewDto.id);
                      await controller.updateRating(controller.store.id);
                      await controller.getStoreById(controller.store.id);
                      controller.imageController.deleteImage();
                      await controller.reviewController.getAllByStore(controller.store.id, controller.userController.user.id);

                      Get.back();
                    }),
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  build_rating() {
    return RatingBar(
      initialRating: controller.reviewController.reviewDto.rating,
      minRating: 0,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemSize: 35.sp,
      ratingWidget: RatingWidget(
        full: Image.asset('assets/icons/star.png'),
        half: Image.asset('assets/icons/rating.png'),
        empty: Image.asset('assets/icons/star.png', color: OnemmColor.LIGHT_GRAY_COLOR),
      ),
      itemPadding: EdgeInsets.symmetric(horizontal: 4.w),
      glow: false,
      updateOnDrag: true,
      onRatingUpdate: (double rating) {
        this.rating = rating;
      },
    );
  }

  build_content() {
    return TextFormField(
      initialValue: 'dsf',
      style: TextStyle(fontSize: FontSize.BASIC_TEXT.sp),
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 20),
        filled: true,
        fillColor: OnemmColor.GRAY_COLOR_1,
        errorStyle: TextStyle(
          fontSize: 14,
        ),
        hintText: '리뷰를 작성해주세요',
        hintStyle: TextStyle(
          fontSize: 15,
          color: OnemmColor.GRAY_COLOR_10,
        ),
      ),
      maxLines: 10,
      minLines: 6,
      onSaved: (val) {
        this.content = val ?? "";
      },
      validator: (val) {
        return null;
      },
    );
  }
}
