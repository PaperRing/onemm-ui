import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:onemm/app/controller/store_controller.dart';
import 'package:onemm/app/ui/component/selected_place.dart';

import '../../common/style.dart';
import '../../component/text_button.dart';

class MainPopular extends GetView<StoreController> {
  const MainPopular({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: CustomStyle.PADDING,
      child: Container(
        width: double.maxFinite,
        decoration: CustomStyle.CONTAINER_CIRCLE,
        padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 20.w, bottom: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MainTextButton("여기 지금 핫플 now🔥"),
            Padding(padding: EdgeInsets.only(top: 15.w), child: SelectedPlace()),
          ],
        ),
      ),
    );
  }
}
