import 'package:get/get.dart';
import 'package:onemm/app/controller/dto/review_dto.dart';
import 'package:onemm/app/controller/image_controller.dart';
import 'package:onemm/app/mapper/review_mapper.dart';

import '../model/review.dart';

class ReviewController extends GetxController {
  late ImageController imageController;
  RxBool isLoading = false.obs;
  final ReviewMapper reviewMapper;
  final RxList _reviewList = <Review>[].obs;
  final _reviewDto = ReviewDto(0, 0, "", 0, false).obs;
  final RxList _myReviewList = <Review>[].obs;
  final _latestReviewImage = ReviewDto(0, 0, "", 0, false).obs;

  ReviewController({required this.reviewMapper});

  get reviewList => _reviewList.value;

  set reviewList(value) => _reviewList.value = value;

  get reviewDto => _reviewDto.value;

  set reviewDto(value) => _reviewDto.value = value;

  get myReviewList => _myReviewList.value;

  set myReviewList(value) => _myReviewList.value = value;

  get latestReviewImage => _latestReviewImage.value;

  set latestReviewImage(value) => _latestReviewImage.value = value;

  getAllByStore(int storeId, int userId) async {
    return await reviewMapper.getAllByStore(storeId, userId).then((data) {
      reviewList = data;
    });
  }

  getOrderBySelectedReview(int storeId, int id, int userId) async {
    return await reviewMapper.getOrderBySelectedReview(storeId, id, userId).then((data) {
      reviewList = data;
    });
  }

  Future<void> saveReview(Map<String, dynamic> review) async {
    await reviewMapper.saveReview(review);
  }

  getReviewById(int id) async {
    reviewDto = await reviewMapper.getReviewById(id);
    if(reviewDto.s3 == true){
      imageController.imageBool.value = true;
    }
  }

  deleteReview(int id) async {
    reviewMapper.deleteReview(id);
  }

  updateReview(Map<String, dynamic> review, int id) async {
    await reviewMapper.updateReview(review, id);
  }

  getReviewByUser(int userId) async {
    return await  reviewMapper.getReviewByUser(userId).then((data) {
      myReviewList = data;
    });
  }

  getLatestReviewImage(int storeId) async {
    // await Future.delayed(const Duration(milliseconds: 1));
    latestReviewImage = await reviewMapper.getLatestReviewImage(storeId);
  }

  addReport(Map<String, dynamic> report) async{
    await reviewMapper.addReport(report);
  }

  @override
  void onInit() {
    imageController = Get.find<ImageController>();
    super.onInit();
  }
}
