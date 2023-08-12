import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_icons/line_icons.dart';

import '../common/style.dart';

class LocationButton extends StatelessWidget {
  final VoidCallback onPress;
  final fontSize;
  final Color color;
  final FontWeight fontWeight;

  const LocationButton({super.key, required this.onPress, required this.fontSize, required this.color, required this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('현재 관악구 장소들만 제공중이에요'),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Text('다른 지역도 얼른 준비할게요😉'),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    child: Text('확인'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            });
      },
      child: Row(
        children: [
          Text('관악구', style: TextStyle(color: color, fontSize: fontSize, fontWeight: fontWeight)),
          SizedBox(width: 8.w),
          Icon(LineIcons.angleDown, color: OnemmColor.DARK_GRAY_COLOR, size: 14.w),
        ],
      ),
    );
  }
}
