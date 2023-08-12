import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:onemm/app/controller/store_controller.dart';
import 'package:onemm/app/ui/common/category.dart';
import 'package:onemm/app/ui/nearby/store_list/component/store_list_view.dart';

import '../../../common/style.dart';

class StoreCategory extends GetView<StoreController> {
  late final int selectedPage;

  StoreCategory(this.selectedPage);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: selectedPage,
        length: 6,
        child: Column(
          children: <Widget>[
            getTabBar(),
            Container(height: 1.h, color: OnemmColor.GRAY_COLOR_3),
            // StoreFilters(),
            Container(height: 1.h, color: OnemmColor.GRAY_COLOR_3),
            tabBarView(context),
          ],
        ));
  }

  TabBar getTabBar() {
    return TabBar(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.w),
        labelPadding: EdgeInsets.symmetric(horizontal: 23.w, vertical: 8.w),
        isScrollable: true,
        indicator: ShapeDecoration(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
          color: OnemmColor.ONE_MM_COLOR,
        ),
        tabs: tabCategoryList.map((e) => Tab(child: Text(e, style: CustomStyle.TAB_TEXT_COLOR))).toList());
  }

  TabBarView getTabBarView(tabs) {
    return TabBarView(
      children: tabs,
    );
  }

  Expanded tabBarView(context) {
    Future loadData(data) async {
      showDialog(
          context: context,
          builder: (context) {
            return const Center(child: CircularProgressIndicator());
          });
      data;
      Navigator.of(context).pop();
    }

    return Expanded(
      child: getTabBarView(
        <Widget>[
          StoreListView(),
          StoreListView(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "준비중",
                style: TextStyle(fontSize: FontSize.BASIC_TEXT.sp, color: OnemmColor.COMMON_TEXT_COLOR, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.h),
              Icon(Icons.settings),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "준비중",
                style: TextStyle(fontSize: FontSize.BASIC_TEXT.sp, color: OnemmColor.COMMON_TEXT_COLOR, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.h),
              Icon(Icons.settings),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "준비중",
                style: TextStyle(fontSize: FontSize.BASIC_TEXT.sp, color: OnemmColor.COMMON_TEXT_COLOR, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.h),
              Icon(Icons.settings),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "준비중",
                style: TextStyle(fontSize: FontSize.BASIC_TEXT.sp, color: OnemmColor.COMMON_TEXT_COLOR, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.h),
              Icon(Icons.settings),
            ],
          ),
        ],
      ),
    );
  }
}
