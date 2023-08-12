import 'dart:convert';

import 'package:get/get.dart';

import '../component/http.dart';
import '../config/host_config.dart';
import '../controller/dto/review_dto.dart';
import '../model/review.dart';

class ReviewMapper extends GetConnect {
  var url = "${HostConfig.host}/review";

  getAllByStore(int storeId, int userId) async {
    List<dynamic> response = await Http.I.get("$url/store/$storeId/$userId", decode: true);
    List<Review> reviewList = response.map((json) => Review.fromJson(json)).toList();
    return reviewList;
  }

  getOrderBySelectedReview(int storeId, int id, int userId) async {
    List<dynamic> response = await Http.I.get("$url/order/$id/$storeId/$userId", decode: true);
    List<Review> reviewList = response.map((json) => Review.fromJson(json)).toList();
    return reviewList;
  }

  saveReview(Map<String, dynamic> review) async {
    await Http.I.post(
      "$url/save",
      body: jsonEncode(review),
      header: {'Content-Type': 'application/json'},
      decode: false,
    );
  }

  updateReview(Map<String, dynamic> review, int id) async {
    await Http.I.update(
      "$url/update/${id}",
      header: {'Content-Type': 'application/json'},
      body: jsonEncode(review),
      decode: false,
    );
  }

  getReviewById(int id) async {
    var response = await Http.I.get("$url/$id", decode: true);
    ReviewDto review = ReviewDto.fromJson(response);
    return review;
  }

  void deleteReview(int id) async {
    await Http.I.delete(
      "$url/delete/${id}",
      header: {'Content-Type': 'application/json'},
      decode: false,
    );
  }

  getReviewByUser(int userId) async{
    List<dynamic> response = await Http.I.get("$url/user/$userId", decode: true);
    List<Review> reviewList = response.map((json) => Review.fromJson(json)).toList();
    return reviewList;
  }

  getLatestReviewImage(int storeId) async{
    var response = await Http.I.get("$url/get/latest/$storeId", decode: true);
    ReviewDto review = ReviewDto.fromJson(response);
    return review;
  }

  addReport(Map<String, dynamic> report) async{
    await Http.I.post(
      "$url/report/add",
      body: jsonEncode(report),
      header: {'Content-Type': 'application/json'},
      decode: false,
    );
  }
}
