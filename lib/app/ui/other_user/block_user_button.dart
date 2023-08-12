import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:onemm/app/controller/store_controller.dart';
import 'package:onemm/app/ui/common/style.dart';

import '../../model/block_user.dart';
import '../../routes/app_routes.dart';

class BlockUserButton extends GetView<StoreController> {
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
                              title: Text('정말로 ${controller.userController.otherUserInfo.name}님을 차단하시겠어요?'),
                              content: SingleChildScrollView(
                                child: Text(
                                  '해당 유저를 차단하면 서로에게 남긴 댓글과 좋아요가 모두 삭제되고 복구가 불가능합니다. 또한 서로의 리뷰, 테마리스트, 프로필을 볼 수 없게됩니다.',
                                  style: TextStyle(fontSize: FontSize.BASIC_TEXT.sp),
                                ),
                              ),
                              actions: [
                                TextButton(
                                  child: Text('확인'),
                                  onPressed: () async {
                                    if (controller.userController.uid == '') {
                                      Navigator.of(context).pop();
                                      Get.toNamed(AppRoutes.MYPAGE);
                                      controller.currentIndex.value = 4;
                                      Get.snackbar('로그인을 해주세요!', '');
                                    } else {
                                      BlockUser user = BlockUser(controller.userController.otherUserInfo.id, controller.userController.user.id);
                                      await controller.userController.addBlockUser(user.toJson());
                                      Navigator.of(context).pop();
                                      Get.back();
                                    }
                                  },
                                ),
                                TextButton(
                                  child: Text(
                                    '취소',
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          });
                    },
                    child: Text(
                      "차단하기",
                      style: TextStyle(fontSize: FontSize.TITLE_MIDDLE_16.sp),
                    )),
              ],
              cancelButton: CupertinoActionSheetAction(
                  child: Text(
                    '취소',
                    style: TextStyle(fontSize: FontSize.TITLE_MIDDLE_16.sp),
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
      ),
    );
  }
}
