import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:onemm/app/controller/store_controller.dart';

import '../../../routes/app_routes.dart';
import '../../common/style.dart';

class SearchListView extends GetView<StoreController> {
  const SearchListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: controller.searchController.record.length,
          itemBuilder: (BuildContext context, int i) {
            return Obx(() {
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () async {
                        await controller.searchController.searchStoreName(controller.searchController.record[i].record);
                        Get.toNamed(AppRoutes.SEARCH_RESULT, arguments: controller.searchController.record[i].record);
                      },
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/icons/location-pin.png',
                            height: 18.h,
                            color: OnemmColor.GRAY_COLOR_10,
                          ),
                          SizedBox(width: 10.w),
                          Text("${controller.searchController.record[i].record}", style: TextStyle(fontSize: 14.sp, color: Colors.black87)),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () async {
                            await controller.searchController.deleteRecord(controller.searchController.record[i].id);
                            await controller.searchController.getSearchRecord(controller.searchController.record[i].userId);
                            Get.toNamed(AppRoutes.SEARCH);
                          },
                          child: const Icon(
                            Icons.close,
                            color: OnemmColor.GRAY_COLOR_10,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              );
            });
          },
        ),
      ],
    );
  }
}
