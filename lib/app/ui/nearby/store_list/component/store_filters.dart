import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:onemm/app/ui/common/style.dart';

const List<String> list = <String>['거리순', '인기순', 'Three', 'Four'];

class StoreFilters extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final RxString dropdownValue = list.first.obs;

    return Container(
      padding: EdgeInsets.only(left: 20.w, right: 20.w),
      child: Obx(() {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                currentLocation(),
                // dropDownButton(dropdownValue),
              ],
            ),
            // nearByButton(),
          ],
        );
      }),
    );
  }

  TextButton currentLocation() {
    return TextButton(
      style: CustomStyle.TEXT_BUTTON_NO_PADDING,
      onPressed: () {},
      child: Row(
        children: [
          Image.asset(
            'assets/icons/location-pin (1).png',
            height: 14.h,
            color: OnemmColor.ONE_MM_COLOR,
          ),
          SizedBox(width: 4.w),
          Text("봉천동", style: TextStyle(color: Colors.black87, fontSize: 14.sp)),
          SizedBox(width: 16.w),
        ],
      ),
    );
  }

  IconButton nearByButton() {
    return IconButton(
      onPressed: () {
        // Get.to(MyNaverMap());
      },
      icon: Image.asset('assets/icons/current.png', color: OnemmColor.DARK_GRAY_COLOR, height: 20.h),
    );
  }

  DropdownButton<String> dropDownButton(RxString dropdownValue) {
    return DropdownButton<String>(
      value: dropdownValue.value,
      icon: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(LineIcons.angleDown, color: OnemmColor.DARK_GRAY_COLOR, size: 14.w),
      ),
      elevation: 1,
      style: TextStyle(color: Colors.black, fontSize: 14.sp),
      onChanged: (String? value) {
        dropdownValue.value = value!;
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
