import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../model/category.dart';
import '../../../../model/menu.dart';
import '../../../../model/review.dart';
import '../../../common/style.dart';
import 'detail_col_text_element.dart';

class ListWidget {
  List<Widget> getFacility(val) {
    List facilityList = val;
    Map<int, dynamic> facMap = {};
    facilityList.map((e) => facMap[e.id] = e.name).toList();

    List<Widget> facList = [];
    facMap.forEach((key, value) {
      if (key == 1) {
        facList.add(DetailColTextElement(Icons.local_parking, "주차"));
        facList.add(SizedBox(width: 25.w));
      } else if (key == 5) {
        facList.add(DetailColTextElement(Icons.table_restaurant, "단체석"));
        facList.add(SizedBox(width: 25.w));
      } else if (key == 6) {
        facList.add(DetailColTextElement(Icons.receipt, "예약"));
        facList.add(SizedBox(width: 25.w));
      } else if (key == 10) {
        facList.add(DetailColTextElement(Icons.wifi, "wifi"));
        facList.add(SizedBox(width: 25.w));
      }
    });
    return facList;
  }

  List<Widget> getMenu(val) {
    List<MenuList> menuList = val;
    List<Widget> menuItems = menuList
        .map((e) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("${e.name} ", style: TextStyle(fontSize: FontSize.BASIC_TEXT.sp, color: OnemmColor.COMMON_TEXT_COLOR)),
                  Text("${e.price} ", style: TextStyle(fontSize: FontSize.BASIC_TEXT.sp, color: OnemmColor.COMMON_TEXT_COLOR)),
                ],
              ),
            ))
        .toList();
    return menuItems;
  }

  List<Widget> getCategory(val) {
    List<Category> categoryList = val;
    List<Widget> categories = categoryList
        .map((e) => Text(
              "${e.name} ",
              style: TextStyle(fontSize: FontSize.BASIC_TEXT.sp, color: OnemmColor.DARK_GRAY_COLOR),
            ))
        .toList();
    return categories;
  }

  List<Widget> getReview(val) {
    List<Review> reviewList = val;
    List<Widget> reviews = reviewList
        .map((e) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                Row(
                  children: [
                    Icon(Icons.person_pin, size: 30.sp),
                    SizedBox(width: 7.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("리뷰어", style: TextStyle(fontSize: FontSize.BASIC_TEXT.sp)),
                        Row(
                          children: [
                            Icon(Icons.star, color: OnemmColor.ONE_MM_COLOR, size: 20.sp),
                            Icon(Icons.star, color: OnemmColor.ONE_MM_COLOR, size: 20.sp),
                            Icon(Icons.star, color: OnemmColor.ONE_MM_COLOR, size: 20.sp),
                            Icon(Icons.star, color: OnemmColor.ONE_MM_COLOR, size: 20.sp),
                            Icon(Icons.star_half_outlined, color: OnemmColor.ONE_MM_COLOR, size: 20.sp),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 5.h),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 10.w),
                  decoration: BoxDecoration(color: OnemmColor.GRAY_COLOR_3, borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                          child: RichText(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        // strutStyle: StrutStyle(fontSize: 16.0),
                        text: TextSpan(
                          text:
                              '세계문자 가운데 한글,즉 훈민정음은 흔히들 신비로운 문자라 부르곤 합니다. 그것은 세계 문자 가운데 유일하게 한글만이 그것을 만든 사람과 반포일을 알며, 글자를 만든 원리까지 알기 때문입니다. 세계에 이런 문자는 없습니다. 그래서 한글은, 정확히 말해 [훈민정음 해례본](국보 70호)은 진즉에 유네스코 세계기록유산으로 등재되었습니다. ‘한글’이라는 이름은 1910년대 초에 주시경 선생을 비롯한 한글학자들이 쓰기 시작한 것입니다. 여기서 ‘한’이란 크다는 것을 뜻하니, 한글은 ‘큰 글’을 말한다고 하겠습니다.[네이버 지식백과] 한글 - 세상에서 가장 신비한 문자 (위대한 문화유산, 최준식)',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: FontSize.BASIC_TEXT.sp,
                          ),
                        ),
                      )),
                    ],
                  ),
                ),
              ],
            ))
        .toList();
    return reviews;
  }
}
