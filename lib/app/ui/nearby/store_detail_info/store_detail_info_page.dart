import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:onemm/app/controller/store_controller.dart';
import 'package:onemm/app/ui/common/app_bar_back_icon.dart';

import '../../component/store_detail_image_box.dart';
import 'detail_info_view.dart';

class StoreDetailInfoPage extends GetView<StoreController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        physics: const ScrollPhysics(),
        shrinkWrap: true,
        children: [
          SizedBox(
            height: 180.h,
            child: Stack(
              children: [
                StoreDetailImageBox(controller.store.id),
                Obx(() {
                  return AppBarBackButton(controller.store.name);
                }),
                Positioned(
                  top: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: AppBarBackButton(controller.store.name),
                ),
              ],
            ),
          ),
          SizedBox(height: 25.h),
          DetailInfoView(),
        ],
      ),
    );
  }
}
