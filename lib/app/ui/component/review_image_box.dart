import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onemm/app/controller/store_controller.dart';

class ReviewImageBox extends GetView<StoreController> {
  final int storeId;
  final int userId;
  final bool s3;

  ReviewImageBox(this.storeId, this.userId, this.s3);

  @override
  Widget build(BuildContext context) {
    final _imageSize = MediaQuery.of(context).size.width / 2.5;

    return s3
        ? Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Container(
              height: _imageSize,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage("https://onemm-bucket.s3.ap-northeast-2.amazonaws.com/review/${storeId}_${userId}"),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          )
        : SizedBox();
  }
}
