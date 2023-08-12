import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onemm/app/controller/store_controller.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../common/style.dart';

class ImageUploadSheetButton extends GetView<StoreController> {
  @override
  Widget build(BuildContext context) {
    final _imageSize = MediaQuery.of(context).size.width / 4;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ZoomTapAnimation(
          child: InkWell(
            onTap: () {
              showCupertinoModalPopup(
                context: context,
                builder: (context) {
                  return CupertinoActionSheet(
                    actions: [
                      CupertinoActionSheetAction(
                          onPressed: () {
                            controller.imageController.deleteImage();
                            controller.imageController.getImage(ImageSource.camera);
                            controller.imageController.imageBool.value = true;
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "촬영하기",
                            // style: TextStyle(fontSize: 15),
                          )),
                      CupertinoActionSheetAction(
                          onPressed: () {
                            controller.imageController.deleteImage();
                            controller.imageController.getImage(ImageSource.gallery);
                            controller.imageController.imageBool.value = true;
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "사진첩에서 불러오기",
                            // style: TextStyle(fontSize: 15),
                          )),
                    ],
                    cancelButton: CupertinoActionSheetAction(
                        child: const Text(
                          '취소',
                          // style: TextStyle(fontSize: 15),
                        ),
                        onPressed: () {
                          HapticFeedback.mediumImpact();
                          Navigator.of(context).pop();
                        }),
                  );
                },
              );
            },
            child: InkWell(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: OnemmColor.ONE_MM_COLOR),
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                ),
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/icons/camera.png',
                      height: 15.h,
                    ),
                    SizedBox(width: 3.w),
                    Text(
                      '사진추가',
                      style: TextStyle(fontSize: FontSize.BASIC_TEXT.sp, color: Colors.black, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(width: 5.w),
                    Text(
                      '최대1개',
                      style: TextStyle(fontSize: FontSize.MIDDLE_TEXT_13.sp, color: OnemmColor.DARK_GRAY_COLOR, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
