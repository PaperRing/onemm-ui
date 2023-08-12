import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:onemm/app/ui/common/review_app_bar.dart';

import '../../../controller/dto/review_dto.dart';
import '../../../controller/store_controller.dart';
import '../../common/style.dart';
import '../../component/image_upload_sheet.dart';
import '../../component/save_button.dart';
import 'component/review_image_box.dart';
import 'component/review_rating_bar.dart';
import 'component/review_text_form.dart';

class MyUpdateReviewPage extends GetView<StoreController> {
  final _formKey = GlobalKey<FormState>();
  double rating = -1;
  String content = '';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: ReviewAppBar(controller.store.name, controller.store.id),
          body: ListView(
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            children: [
              Form(
                key: this._formKey,
                child: Padding(
                  padding: CustomStyle.PADDING,
                  child: Obx(() {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 5.h),
                        ReviewRatingBar(controller.reviewController.reviewDto.rating, this.rating),
                        SizedBox(height: 20.h),
                        ReviewTextFormField(controller.reviewController.reviewDto.content, this.content),
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
                        SaveButton(
                          () async {
                            _formKey.currentState?.save();
                            if (controller.imageController.selectedImagePath.value != '') {
                              var url = await controller.imageController.getS3PreSignedUrl("review", "${controller.store.id}_${controller.userController.user.id}");
                              File image = File(controller.imageController.selectedImagePath!.value);
                              await controller.imageController.putS3(url, image);
                              imageCache.clear();
                              imageCache.clearLiveImages();
                            }

                            ReviewDto newReview = ReviewDto(controller.store.id, controller.userController.user.id, content, rating == -1 ? controller.reviewController.reviewDto.rating : rating,
                                controller.imageController.imageBool.value);
                            await controller.reviewController.updateReview(newReview.toJson(), controller.reviewController.reviewDto.id);
                            await controller.updateRating(controller.reviewController.reviewDto.storeId);
                            await controller.reviewController.getReviewByUser(controller.userController.user.id);
                            await controller.imageController.deleteImage();
                            Get.back();
                          },
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
