import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:onemm/app/controller/store_controller.dart';
import 'package:onemm/app/routes/app_routes.dart';
import 'package:onemm/app/ui/search/component/search_store_list_view.dart';

import '../../common/bottom_navigator.dart';
import '../../common/style.dart';

class SearchResultPage extends GetView<StoreController> {
  final _formKey = GlobalKey<FormState>();
  late String search = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigator(),
      body: SafeArea(
        child: Form(
          key: this._formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                autofocus: false,
                initialValue: Get.arguments,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 13.h),
                  prefixIcon: InkWell(
                    onTap: () async {
                      if (controller.userController.uid != '') {
                        await controller.searchController.getSearchRecord(controller.userController.user.id);
                      }
                      Get.offAndToNamed(AppRoutes.SEARCH);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25, right: 10),
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        size: 23.sp,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  hintText: '도시 또는 장소를 검색하세요',
                  hintStyle: TextStyle(fontSize: 14.sp),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: OnemmColor.GRAY_COLOR_8),
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: OnemmColor.GRAY_COLOR_8),
                  ),
                ),
                style: TextStyle(decoration: TextDecoration.none, fontSize: 16.sp),
                onFieldSubmitted: (val) async {
                  this.search = val!;
                  await controller.searchStoreName(this.search);
                },
                validator: (val) {
                  if (val == null || val.isEmpty) {}
                },
              ),
              Expanded(child: SearchStoreListView())
            ],
          ),
        ),
      ),
    );
  }
}
