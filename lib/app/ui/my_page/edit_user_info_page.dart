import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:image_picker/image_picker.dart';

import '../../controller/user_controller.dart';
import '../../model/user_db.dart';
import '../common/app_bar_back_icon_black.dart';
import '../common/style.dart';
import '../component/save_button.dart';

class EditUserInfoPage extends GetView<UserController> {
  final _formKey = GlobalKey<FormState>();
  String nickName = '';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarBackButtonBlack(""),
        body: Container(
          padding: CustomStyle.PADDING,
          child: Form(
            key: this._formKey,
            child: Column(
              children: [
                InkWell(
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
                                  child: Text("촬영하기")),
                              CupertinoActionSheetAction(
                                  onPressed: () {
                                    controller.imageController.deleteImage();
                                    controller.imageController.getImage(ImageSource.gallery);
                                    controller.imageController.imageBool.value = true;
                                    Navigator.pop(context);
                                  },
                                  child: Text("사진첩에서 불러오기")),
                            ],
                            cancelButton: CupertinoActionSheetAction(
                                child: Text('취소'),
                                onPressed: () {
                                  HapticFeedback.mediumImpact();
                                  Navigator.of(context).pop();
                                }),
                          );
                        });
                  },
                  child: Obx(() {
                    return Stack(
                      children: [
                        SizedBox(
                          width: 90.w,
                          height: 80.h,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(65),
                            child: buildImage(),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 25.w,
                            height: 25.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey[100],
                            ),
                            child: Icon(
                              Icons.camera_alt_outlined,
                              size: 16.sp,
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                ),
                SizedBox(height: 30.h),
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.only(top: 8, bottom: 8, left: 10, right: 10),
                    filled: true,
                    fillColor: OnemmColor.GRAY_COLOR_1,
                    errorStyle: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                  maxLength: 8,
                  autofocus: false,
                  initialValue: controller.user.name,
                  style: TextStyle(color: Colors.black87, fontSize: FontSize.TITLE_MIDDLE_16.sp),
                  onSaved: (val) {
                    this.nickName = val!;
                    print(val);
                  },
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return '닉네임을 한글자 이상 입력해주세요.';
                    }
                  },
                ),
                SizedBox(height: 30.h),
                SaveButton(() async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState?.save();

                    if (controller.imageController.selectedImagePath.value != '') {
                      UserDB newUser = UserDB(controller.uid, this.nickName, null, controller.user.location, controller.imageController.imageBool.value);
                      await controller.updateUser(controller.uid, newUser.toJson());
                      var url = await controller.imageController.getS3PreSignedUrl("profile", "${controller.user.id}");
                      File image = File(controller.imageController.selectedImagePath!.value);
                      await controller.imageController.putS3(url, image);
                      imageCache.clear();
                      imageCache.clearLiveImages();
                    } else {
                      UserDB newUser = UserDB(controller.uid, this.nickName, controller.photoUrl, controller.user.location, controller.user.s3);
                      await controller.updateUser(controller.uid, newUser.toJson());
                    }

                    await controller.getCurrentUser();
                    controller.imageController.imageBool.value = false;
                    Get.back();
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildImage() {
    if (controller.imageController.selectedImagePath != '') {
      return Image.file(
        File(controller.imageController.selectedImagePath.value),
        fit: BoxFit.cover,
      );
    } else if (controller.user.s3 == true) {
      return Image.network(
        "https://onemm-bucket.s3.ap-northeast-2.amazonaws.com/profile/${controller.user.id}",
        fit: BoxFit.cover,
      );
    }
    return Image.network(
      controller.user.photoUrl ?? '',
      fit: BoxFit.cover,
    );
  }
}
