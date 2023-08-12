import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:onemm/app/controller/store_controller.dart';

import '../../../common/style.dart';

class ReviewTextFormField extends GetView<StoreController> {
  final String initialContent;
  late String content;

  ReviewTextFormField(this.initialContent, this.content);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialContent ?? "",
      style: TextStyle(fontSize: FontSize.BASIC_TEXT.sp),
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 20),
        filled: true,
        fillColor: OnemmColor.GRAY_COLOR_1,
        errorStyle: TextStyle(
          fontSize: 14,
        ),
        hintText: '리뷰를 작성해주세요',
        hintStyle: TextStyle(
          fontSize: 15,
          color: OnemmColor.GRAY_COLOR_10,
        ),
      ),
      maxLines: 10,
      minLines: 6,
      onSaved: (val) {
        this.content = val ?? "";
      },
      validator: (val) {
        return null;
      },
    );
  }
}
