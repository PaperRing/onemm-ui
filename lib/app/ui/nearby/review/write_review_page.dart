import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:onemm/app/controller/dto/review_dto.dart';
import 'package:onemm/app/controller/store_controller.dart';
import 'package:onemm/app/routes/app_routes.dart';

import '../../common/review_app_bar.dart';
import '../../common/style.dart';
import '../../component/image_upload_sheet.dart';
import '../../component/save_button.dart';

class WriteReviewPage extends GetView<StoreController> {
  final _formKey = GlobalKey<FormState>();
  double rating = 0;
  String content = '';

  @override
  Widget build(BuildContext context) {
    final imageSize = MediaQuery.of(context).size.width / 3;

    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: ReviewAppBar(Get.arguments, controller.store.id),
          body: SingleChildScrollView(
            child: SafeArea(
              child: Obx(() {
                return Form(
                  key: this._formKey,
                  child: Padding(
                    padding: CustomStyle.PADDING,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 5.h),
                        build_rating(),
                        SizedBox(height: 20.h),
                        build_content(),
                        SizedBox(height: 30.h),
                        controller.imageController.selectedImagePath!.value != ''
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: Container(
                                      width: imageSize,
                                      height: imageSize,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                                        image: DecorationImage(
                                          image: FileImage(File(controller.imageController.selectedImagePath.value)),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      child: GestureDetector(
                                        child: const Icon(
                                          Icons.delete,
                                          color: Colors.white,
                                        ),
                                        onTap: () {
                                          controller.reviewController.imageController.deleteImage();
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : const SizedBox(),
                        ImageUploadSheetButton(),
                        SizedBox(height: 15.h),
                        SaveButton(() async {
                          if (this._formKey.currentState!.validate()) {
                            Get.snackbar(
                              '리뷰 완료',
                              '작성한 리뷰를 확인해보세요!',
                              backgroundColor: OnemmColor.LIGHT_GRAY_COLOR,
                            );
                          }
                          _formKey.currentState?.save();
                          if (controller.imageController.selectedImagePath!.value != '') {
                            //s3 파일업로드
                            var url = await controller.imageController.getS3PreSignedUrl("review", "${controller.store.id}_${controller.userController.user.id}");
                            File image = File(controller.imageController.selectedImagePath!.value);
                            controller.imageController.imageBool.value = true;
                            await controller.imageController.putS3(url, image);
                          }

                          ReviewDto newReview = ReviewDto(controller.store.id, controller.userController.user.id, content, rating, controller.imageController.imageBool.value);
                          print(controller.imageController.imageBool.value);

                          await controller.reviewController.saveReview(newReview.toJson());
                          await controller.updateRating(controller.store.id);
                          await controller.reviewController.getAllByStore(controller.store.id, controller.userController.user.id);
                          await controller.getStoreById(controller.store.id);

                          Get.offNamed(AppRoutes.STORE_ALL_REVIEW, arguments: controller.store.name);
                          await controller.imageController.deleteImage();
                        }),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ));
  }

  build_rating() {
    return RatingBar(
      initialRating: 0,
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
