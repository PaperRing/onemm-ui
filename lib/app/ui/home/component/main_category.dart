import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:onemm/app/controller/store_controller.dart';
import 'package:onemm/app/ui/common/style.dart';
import 'package:onemm/app/ui/component/text_button.dart';

import '../../nearby/near_by_page.dart';

class MainCategory extends GetView<StoreController> {
  final categoryWidth = 14.w;
  final RxBool _more = false.obs;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 10.w, top: 2.w),
      child: Container(
        decoration: CustomStyle.CONTAINER_CIRCLE,
        padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 20.w, bottom: 15.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MainTextButton("어디로 갈까요?"),
            SizedBox(height: 5.h),
            categoryListRow(context),
          ],
        ),
      ),
    );
  }

  categoryListRow(context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      category('assets/icons/coffee.png', '카페', 22, const Color.fromRGBO(244, 162, 97, 0.8), 0, context),
      category('assets/icons/food.png', '식당', 22, Colors.grey, 1, context),
      category('assets/icons/alcohol.png', '알콜', 22, const Color.fromRGBO(231, 111, 81, 0.8), 2, context),
      category('assets/icons/ball.png', '운동장', 21, const Color.fromRGBO(38, 70, 83, 0.8), 3, context),
      category('assets/icons/hospital.png', '동물병원', 21, const Color.fromRGBO(42, 157, 143, 0.8), 4, context),
    ]);
  }

  Row category(dynamic image, String name, int height, Color color, int i, context) {
    return Row(
      children: [
        Column(
          children: [
            IconButton(
              icon: Image.asset(
                image,
                height: height.h,
                color: color,
              ),
              onPressed: () async {
                int result = i + 1;
                await loadData(context);
                controller.currentIndex.value = 2;
                Get.to(NearByPage(selected: result));
              },
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 6.w),
              child: Text(
                name,
                style: TextStyle(color: Colors.black, fontSize: FontSize.BASIC_SMALL_TEXT.sp, fontWeight: FontWeight.w400),
              ),
            )
          ],
        ),
        // SizedBox(width: 12.w)
      ],
    );
  }

  Future loadData(context) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });

    await controller.getAllStoresWithCategory();

    Navigator.of(context).pop();
  }
}
