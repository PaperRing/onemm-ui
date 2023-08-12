import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchTextTitle extends StatelessWidget {
  final String title;

  const SearchTextTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20.h, bottom: 5.h),
      child: Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp)),
    );
    ;
  }
}
