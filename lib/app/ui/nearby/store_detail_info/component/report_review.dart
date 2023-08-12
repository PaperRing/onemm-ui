import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:onemm/app/controller/store_controller.dart';
import 'package:onemm/app/model/report.dart';
import 'package:onemm/app/routes/app_routes.dart';

class ReportReview extends GetView<StoreController> {
  int reviewId;

  ReportReview(this.reviewId);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showCupertinoModalPopup(
          context: context,
          builder: (context) {
            return CupertinoActionSheet(
              actions: [
                CupertinoActionSheetAction(
                    onPressed: () {
                      HapticFeedback.mediumImpact();
                      Navigator.of(context).pop();
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text(
                                '이 리뷰가 부적절한가요?',
                                style: TextStyle(fontSize: 15),
                              ),
                              content: const SingleChildScrollView(
                                child: Text(
                                  '신고해주시면 검토후에 처리됩니다.',
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                              actions: [
                                TextButton(
                                  child: const Text(
                                    '확인',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  onPressed: () async {
                                    if (controller.userController.uid == '') {
                                      Navigator.of(context).pop();
                                      Get.toNamed(AppRoutes.MYPAGE);
                                      controller.currentIndex.value = 4;
                                      Get.snackbar('로그인을 해주세요!', '');
                                    } else {
                                      Report report = Report(reviewId, controller.userController.user.id);
                                      await controller.reviewController.addReport(report.toJson());
                                      Navigator.of(context).pop();
                                    }
                                  },
                                ),
                                TextButton(
                                  child: const Text(
                                    '취소',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          });
                    },
                    child: const Text(
                      "부적절한 리뷰 신고",
                      style: TextStyle(fontSize: 15),
                    )),
              ],
              cancelButton: CupertinoActionSheetAction(
                  child: const Text(
                    '취소',
                    style: TextStyle(fontSize: 15),
                  ),
                  onPressed: () {
                    HapticFeedback.mediumImpact();
                    Navigator.of(context).pop();
                  }),
            );
          },
        );
      },
      child: Image.asset(
        'assets/icons/dots.png',
        height: 20.sp,
        color: Colors.grey,
      ),
    );
  }
}
