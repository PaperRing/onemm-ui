import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:onemm/app/routes/app_routes.dart';
import 'package:onemm/app/ui/nearby/store_list/component/store_info.dart';
import 'package:onemm/app/ui/search/component/search_store_info.dart';

import '../../../controller/store_controller.dart';
import '../../component/store_list_image_box.dart';
import '../../nearby/store_detail_info/component/load_data.dart';


class SearchStoreListView extends GetView<StoreController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: controller.searchList.length,
        itemBuilder: (context, i) {
          return InkWell(
            onTap: () async {
              await LoadData().loadData(controller.searchList[i].id, context);
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
              SearchStoreInfo(i),
              SizedBox(height: 5.h),
              StoreListImageBox(controller.searchList[i].id),
              SizedBox(height: 15.h),
            ],
          ),
        ),
      ],
    );
  }
}
