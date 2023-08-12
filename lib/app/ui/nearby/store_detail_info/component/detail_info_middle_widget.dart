import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onemm/app/ui/nearby/store_detail_info/component/detail_row_text_element.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../common/style.dart';
import 'detail_box.dart';

class DetailInfoMiddleWidget {
  Padding Facility(List<Widget> facList) {
    return Padding(
      padding: EdgeInsets.only(left: 20.w),
      child: Row(children: facList),
    );
  }

  Information(address, tel, homepage) {
    return DetailBox([
      DetailRowTextElement(Icons.pin_drop_outlined, address),
      // Container(height: 1.h, color: OnemmColor.LIGHT_GRAY_COLOR),
      DetailRowTextElement(Icons.watch_later_outlined, "월-금 9:00-19:00"),
      // Container(height: 1.h, color: OnemmColor.LIGHT_GRAY_COLOR),
      DetailRowTextElement(Icons.phone, tel),
      // Container(height: 1.h, color: OnemmColor.LIGHT_GRAY_COLOR),
      Container(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Row(children: [
            Icon(
              Icons.home_filled,
              size: 18.h,
              color: OnemmColor.COMMON_TEXT_COLOR,
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: InkWell(
                onTap: () => launchUrl(Uri.parse(homepage)),
                child: Text(
                  homepage,
                  style: TextStyle(fontSize: FontSize.BASIC_TEXT.sp, color: OnemmColor.COMMON_TEXT_COLOR),
                ),
              ),
            )
          ])),
    ]);
  }

  Menu(menuItems) {
    return DetailBox([
      Text("메뉴", style: TextStyle(fontSize: FontSize.TITLE_MIDDLE_17.sp, fontWeight: FontWeight.bold)),
      SizedBox(height: 10.h),
      Column(children: menuItems),
    ]);
  }
}
