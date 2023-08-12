import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onemm/app/ui/common/app_bar_back_icon_black.dart';
import 'package:onemm/app/ui/common/style.dart';

class QuestionPage extends StatelessWidget {
  const QuestionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarBackButtonBlack(""),
      body: Container(
        padding: CustomStyle.PADDING,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            Text(
              "아래의 이메일로 문의해주세요 :)",
              style: TextStyle(fontSize: FontSize.TITLE_MIDDLE_17.sp),
            ),
            SizedBox(height: 10.h),
            Text(
              "jheee0130@gmail.com",
              style: TextStyle(fontSize: FontSize.TITLE_MIDDLE_17.sp, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
