import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:onemm/app/controller/store_controller.dart';
import 'package:onemm/app/ui/nearby/store_detail_info/component/detail_info_list_widget.dart';
import 'package:onemm/app/ui/nearby/store_detail_info/component/detail_info_middle_widget.dart';
import 'package:onemm/app/ui/nearby/store_detail_info/component/detail_info_review_widget.dart';

import '../../common/style.dart';
import 'component/detail_info_top_widget.dart';

class DetailInfoView extends GetView<StoreController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      List<Widget> categories = ListWidget().getCategory(controller.category);
      List<Widget> menuItems = ListWidget().getMenu(controller.menu);
      List<Widget> facList = ListWidget().getFacility(controller.facility);

      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /** Top Widget **/
            //가게명 & 카테고리
            DetailInfoTopWidget().TitleCategory(categories, controller.store.name),
            SizedBox(height: 5.h),
            //상단 평균 별점
            DetailInfoTopWidget().AverageRating(),
            SizedBox(height: 10.h),
            Container(width: double.infinity, height: 1.h, color: OnemmColor.GRAY_COLOR_1),
            //좋아요, 컬렉션 추가, 공유
            DetailInfoTopWidget().LikeShare(context),
            Container(height: 3.h, color: OnemmColor.LIGHT_GRAY_COLOR),
            SizedBox(height: 10.h),

            /** Middle Widget **/
            //시설정보(아이콘)
            DetailInfoMiddleWidget().Facility(facList),
            // SizedBox(height: 5.h),
            //주소, 운영시간, 전화번호, 홈페이지
            DetailInfoMiddleWidget().Information(controller.store.address, controller.store.tel, controller.store.homepage),
            Container(height: 3.h, color: OnemmColor.LIGHT_GRAY_COLOR),
            SizedBox(height: 10.h),
            //메뉴
            menuItems.isEmpty
                ? Container()
                : Column(
                    children: [
                      DetailInfoMiddleWidget().Menu(menuItems),
                      Container(height: 3.h, color: OnemmColor.LIGHT_GRAY_COLOR),
                      SizedBox(height: 10.h),
                    ],
                  ),

            /** Review **/
            //후기를 남겨주세요 부분
            DetailInfoReviewWidget().AskReview(),
            Container(height: 3.h, color: OnemmColor.LIGHT_GRAY_COLOR),
            SizedBox(height: 10.h),
            DetailInfoReviewWidget().UserReviewTotal(),
            SizedBox(height: 30.h),
          ],
        ),
      );
    });
  }
}
