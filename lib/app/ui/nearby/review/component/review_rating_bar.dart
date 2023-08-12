import 'package:flutter/cupertino.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../controller/store_controller.dart';
import '../../../common/style.dart';

class ReviewRatingBar extends GetView<StoreController> {
  final double initial_rating;
  late double rating;

  ReviewRatingBar(this.initial_rating, this.rating);

  @override
  Widget build(BuildContext context) {
    return RatingBar(
      initialRating: initial_rating,
      minRating: 0,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemSize: 35.sp,
      ratingWidget: RatingWidget(
        full: Image.asset('assets/icons/star.png'),
        half: Image.asset('assets/icons/rating.png'),
        empty: Image.asset('assets/icons/star.png', color: OnemmColor.LIGHT_GRAY_COLOR),
      ),
      itemPadding: EdgeInsets.symmetric(horizontal: 4.w),
      glow: false,
      updateOnDrag: true,
      onRatingUpdate: (double rating) {
        this.rating = rating;
      },
    );
  }
}
