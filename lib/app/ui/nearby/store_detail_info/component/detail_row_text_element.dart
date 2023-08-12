import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/style.dart';

class DetailRowTextElement extends StatelessWidget {
  final icon;
  final value;

  DetailRowTextElement(this.icon, this.value);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 9.h),
        child: Row(children: [
          Icon(
            icon,
            size: 18.h,
            color: OnemmColor.COMMON_TEXT_COLOR,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: FontSize.BASIC_TEXT.sp, color: OnemmColor.COMMON_TEXT_COLOR),
            ),
          )
        ]));
  }
}
