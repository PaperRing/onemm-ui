import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:onemm/app/controller/store_controller.dart';
import 'package:onemm/app/routes/app_routes.dart';
import 'package:onemm/app/ui/common/style.dart';

class BottomNavigator extends GetView<StoreController> {
  @override
  Widget build(BuildContext context) {
    Future loadLikePlace() async {
      showDialog(
          context: context,
          builder: (context) {
            return const Center(child: CircularProgressIndicator());
          });

      await controller.likeStoreController.getLikeByUser(controller.userController.user.id);
      await controller.themeController.getLikeThemeList(controller.userController.user.id);
      if (controller.themeController.likeThemeList.length != 0) {
        await controller.themeController.likeThemeList.map((i) => {controller.themeController.getLikeThemeItems(i.themeId)}).toList();
      }
      Navigator.of(context).pop();
    }

    const _selectedItemColor = OnemmColor.test;
    const _unselectedItemColor = OnemmColor.test;

    Color _getItemColor(int index) => controller.currentIndex == index ? _selectedItemColor : _unselectedItemColor;
    Color _getIconColor(int index) => controller.currentIndex == index ? _selectedItemColor : _unselectedItemColor;

    Widget _buildIcon(String selectedImage, String unSelectedImage, String text, int index, voidCallback) => InkWell(
          onTap: voidCallback,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(controller.currentIndex == index ? unSelectedImage : selectedImage, color: Colors.black, height: 15.h),
              Padding(
                padding: EdgeInsets.only(top: 4.w),
                child: Text(text, style: TextStyle(fontSize: FontSize.SMALL_TEXT_10.sp, color: _getItemColor(index))),
              ),
            ],
          ),
        );

    return Container(
      padding: EdgeInsets.only(top: 10.w, bottom: 20.w, left: 25.w, right: 25.w),
      color: Colors.white,
      child: Obx(() {
        return Wrap(
          direction: Axis.horizontal,
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.spaceBetween,
          children: [
            _buildIcon('assets/icons/home.png', 'assets/icons/home_bold.png', '홈', 0, () async {
              controller.currentIndex.value = 0;
              if (controller.userController.uid != '') {
                await controller.themeController.getThemeListAll(controller.userController.user.id);
              }
              Get.toNamed(AppRoutes.INITIAL);
            }),
            _buildIcon('assets/icons/heart.png', 'assets/icons/heart_bold.png', '찜한곳', 1, () async {
              controller.currentIndex.value = 1;
              if (controller.userController.uid == '') {
                Get.toNamed(AppRoutes.MYPAGE);
              } else {
                await loadLikePlace();
                Get.toNamed(AppRoutes.LIKED);
              }
            }),
            _buildIcon('assets/icons/location-pin.png', 'assets/icons/location-pin_bold.png', '내주변', 2, () async {
              controller.currentIndex.value = 2;
              // await controller.getAllStoresWithCategory();
              Get.toNamed(AppRoutes.NEARBY);
            }),
            _buildIcon('assets/icons/search.png', 'assets/icons/search_bold.png', '검색', 3, () async {
              controller.currentIndex.value = 3;
              if (controller.userController.uid != '') {
                await controller.searchController.getSearchRecord(controller.userController.user.id);
              }
              Get.toNamed(AppRoutes.SEARCH);
            }),
            _buildIcon('assets/icons/user.png', 'assets/icons/user_bold.png', 'My', 4, () async {
              controller.currentIndex.value = 4;
              if (controller.userController.uid != '') {
                await controller.reviewController.getReviewByUser(controller.userController.user.id);
                await controller.themeController.getThemeListAllByUser(controller.userController.user.id);
                try {
                  await controller.userController.getMyFollowing(controller.userController.user.id);
                } catch (e) {}
                try {
                  await controller.userController.getMyFollower(controller.userController.user.id);
                } catch (e) {}
              }

              Get.toNamed(AppRoutes.MYPAGE);
            }),
          ],
        );
      }),
    );
  }
}
