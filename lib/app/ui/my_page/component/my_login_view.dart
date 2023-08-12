import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:onemm/app/controller/store_controller.dart';
import 'package:onemm/app/model/user_db.dart';
import 'package:onemm/app/ui/common/style.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../../component/google_auth.dart';

class MyLoginView extends GetView<StoreController> {
  const MyLoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: CustomStyle.PADDING,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20.h),
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage("assets/splash/logo.png"),
            ),
            SizedBox(height: 30.h),
            Center(
              child: InkWell(
                onTap: () async {
                  try {
                    await GoogleAuth.login();
                    final user = await GoogleAuth.get();

                    await controller.userController.getCurrentUser();

                    if (controller.userController.user.uid == null) {
                      UserDB userDB = UserDB(controller.userController.uid, user.name, controller.userController.photoUrl, "봉천동", false);
                      await controller.userController.saveUser(userDB.toJson());
                    }

                    await controller.userController.getCurrentUser();
                    await controller.reviewController.getReviewByUser(controller.userController.user.id);
                    await controller.themeController.getThemeListAllByUser(controller.userController.user.id);
                    try {
                      await controller.userController.getMyFollowing(controller.userController.user.id);
                    } catch (e) {}
                    try {
                      await controller.userController.getMyFollower(controller.userController.user.id);
                    } catch (e) {}
                  } catch (exception, stackTrace) {
                    await Sentry.captureException(exception, stackTrace: stackTrace);
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: OnemmColor.GRAY_COLOR_3,
                      ),
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Row(
                    children: [
                      Container(
                        height: 50.h,
                        padding: EdgeInsets.all(10),
                        child: Image.asset(
                          "assets/icons/google_logo.png",
                          fit: BoxFit.fill,
                        ),
                      ),
                      Container(
                        width: 220.w,
                        child: Text(
                          "구글로 로그인",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: FontSize.TITLE_MIDDLE_17.sp,
                            color: OnemmColor.COMMON_TEXT_COLOR,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
