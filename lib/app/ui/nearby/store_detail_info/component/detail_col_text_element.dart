import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/style.dart';

class DetailColTextElement extends StatelessWidget {
  final icon;
  final text;

  DetailColTextElement(this.icon, this.text);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(width: 30.w),
      Icon(
        icon,
        size: 22.sp,
        color: OnemmColor.DARK_GRAY_COLOR,
      ),
      SizedBox(height: 3.h),
      Text(text, style: TextStyle(fontSize: FontSize.BASIC_SMALL_TEXT.sp, color: OnemmColor.COMMON_TEXT_COLOR)),
    ]);
  }
}
