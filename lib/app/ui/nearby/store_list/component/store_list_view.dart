import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:onemm/app/routes/app_routes.dart';
import 'package:onemm/app/ui/nearby/store_list/component/store_info.dart';

import '../../../../controller/store_controller.dart';
import '../../../component/store_list_image_box.dart';
import '../../store_detail_info/component/load_data.dart';

class StoreListView extends GetView<StoreController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListView.builder(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemCount: controller.storeDto.length,
        itemBuilder: (context, i) {
          return InkWell(
            onTap: () async {
              await LoadData().loadData(controller.storeDto[i].id, context);
              await Get.toNamed(AppRoutes.STORE_DETAIL);
            },
            child: controller.isLoading.value ? const Center(child: CircularProgressIndicator()) : buildColumn(i),
          );
        },
      );
    });
  }

  Column buildColumn(int i) {
    return Column(
      children: [
        SizedBox(height: 10.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: ListView(
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            children: [
              StoreInfo(i),
              SizedBox(height: 5.h),
              StoreListImageBox(controller.storeDto[i].id),
              SizedBox(height: 10.h),
            ],
          ),
        ),
      ],
    );
  }
}
