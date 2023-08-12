import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../../../controller/store_controller.dart';

class UpdateReviewImageBox extends GetView<StoreController> {
  final int storeId;
  final int userId;

  UpdateReviewImageBox(this.storeId, this.userId);

  @override
  Widget build(BuildContext context) {
    final imageSize = MediaQuery.of(context).size.width / 3;
    controller.imageController.s3DeleteBool.value = false;
    return Obx(() {
      return buildImage(imageSize, this.storeId, this.userId);
    });
  }

  buildImage(size, storeId, userId) {
    if (controller.imageController.selectedImagePath.value != '') {
      return Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Container(
          width: size,
          height: size,
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
      );
    } else if (controller.imageController.s3DeleteBool.value == true) {
      return const SizedBox();
    } else {
      return Container(
        margin: const EdgeInsets.only(bottom: 30),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            image: DecorationImage(
              image: NetworkImage("https://onemm-bucket.s3.ap-northeast-2.amazonaws.com/review/${storeId}_${userId}"),
              fit: BoxFit.fill,
            ),
          ),
          child: GestureDetector(
            child: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
            onTap: () {
              controller.imageController.s3DeleteBool.value = true;
              controller.reviewController.imageController.deleteImage();
            },
          ),
        ),
      );
    }
  }
}
