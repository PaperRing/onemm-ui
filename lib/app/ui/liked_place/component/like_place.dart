import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:onemm/app/controller/store_controller.dart';

import '../../common/style.dart';
import 'like_stores.dart';
import 'like_theme_list.dart';

class LikePlace extends GetView<StoreController> {
  const LikePlace({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          children: [
            const LikeStores(3, "찜한장소"),
            SizedBox(height: 20.h),
            Container(height: 1.h, width: double.infinity, color: OnemmColor.LIGHT_GRAY_COLOR),
            LikeThemeList("찜한 테마리스트"),
          ],
        ),
      ),
    );
  }
}
