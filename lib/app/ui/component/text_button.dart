import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onemm/app/ui/common/style.dart';

class MainTextButton extends StatelessWidget {
  final text;

  MainTextButton(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5.w),
      child: Text(text, style: TextStyle(color: Colors.black, fontSize: FontSize.TITLE_MIDDLE_16.sp, fontWeight: FontWeight.bold)),
    );
  }
}
