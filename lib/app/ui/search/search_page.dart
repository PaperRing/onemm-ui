import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:onemm/app/controller/store_controller.dart';
import 'package:onemm/app/routes/app_routes.dart';

import '../../model/search.dart';
import '../common/bottom_navigator.dart';
import '../common/style.dart';
import 'component/searchListView.dart';
import 'component/searchTextTitle.dart';

class SearchPage extends GetView<StoreController> {
  final _formKey = GlobalKey<FormState>();
  String search = '';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: BottomNavigator(),
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              children: [
                TextFormField(
                  autofocus: false,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 13.h),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 25, right: 10),
                      child: Icon(
                        Icons.search,
                        size: 23.sp,
                        color: Colors.grey,
                      ),
                    ),
                    hintText: '도시 또는 장소를 검색하세요',
                    hintStyle: TextStyle(fontSize: 14.sp),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: OnemmColor.GRAY_COLOR_8),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: OnemmColor.GRAY_COLOR_8),
                    ),
                  ),
                  style: TextStyle(decoration: TextDecoration.none, fontSize: 16.sp),
                  onFieldSubmitted: (val) async {
                    this.search = val!;
                    if (controller.userController.uid != '') {
                      Search newRecord = Search(controller.userController.user.id, this.search);
                      await controller.searchController.saveSearchRecord(newRecord.toJson());
                    }
                    await controller.searchStoreName(this.search);
                    Get.toNamed(AppRoutes.SEARCH_RESULT, arguments: this.search);
                  },
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return '닉네임을 한글자 이상 입력해주세요.';
                    }
                  },
                ),
                Container(
                  padding: CustomStyle.PADDING,
                  child: ListView(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    children: [
                      SearchTextTitle(title: "인기검색어"),
                      Record("듀레스트"),
                      Record("봉천동"),
                      Record("신림동"),
                      SizedBox(height: 30.h),
                      SearchTextTitle(title: "최근 검색어"),
                      SearchListView(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Record(text) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: () {
          this.search = text;
          controller.searchStoreName(text);
          Get.toNamed(AppRoutes.SEARCH_RESULT, arguments: this.search);
        },
        child: Row(
          children: [
            Image.asset(
              'assets/icons/location-pin_bold.png',
              height: 18.h,
              color: OnemmColor.ONE_MM_COLOR_7,
            ),
            SizedBox(width: 10.w),
            Text(text, style: TextStyle(fontSize: 14.sp, color: Colors.black87)),
          ],
        ),
      ),
    );
  }
}
