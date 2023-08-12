import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:onemm/app/controller/store_controller.dart';
import 'package:onemm/app/ui/component/store_image_box.dart';
import 'package:onemm/app/ui/nearby/store_detail_info/component/load_data.dart';

import '../../routes/app_routes.dart';
import 'category_label.dart';

class SelectedPlace extends GetView<StoreController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return controller.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              itemCount: controller.hotPlace.length,
              itemBuilder: (BuildContext context, int i) {
                return InkWell(
                  onTap: () async {
                    await LoadData().loadData(controller.hotPlace[i].id, context);
                    await Get.toNamed(AppRoutes.STORE_DETAIL);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 10.w),
                    child: Row(
                      children: [
                        StoreImageBox(controller.hotPlace[i].id),
                        SizedBox(width: 10.w),
                        CategoryLabel(controller.hotPlace[i].category, controller.hotPlace[i].name, controller.hotPlace[i].averageRating ?? 0),
                      ],
                    ),
                  ),
                );
              },
            );
    });
  }
}
