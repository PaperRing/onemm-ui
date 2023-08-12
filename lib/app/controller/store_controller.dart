import 'package:get/get.dart';
import 'package:onemm/app/controller/image_controller.dart';
import 'package:onemm/app/controller/like_store_controller.dart';
import 'package:onemm/app/controller/review_controller.dart';
import 'package:onemm/app/controller/search_controller.dart';
import 'package:onemm/app/controller/theme_controller.dart';
import 'package:onemm/app/controller/user_controller.dart';
import 'package:onemm/app/model/workday.dart';

import '../mapper/store_mapper.dart';
import '../model/category.dart';
import '../model/facility.dart';
import '../model/menu.dart';
import '../model/store.dart';
import 'dto/store_dto.dart';

class StoreController extends GetxController {
  late ReviewController reviewController;
  late UserController userController;
  late LikeStoreController likeStoreController;
  late ImageController imageController;
  late ThemeController themeController;
  late SearchController searchController;

  RxBool isLoading = false.obs;
  RxBool likePlaceLoading = false.obs;
  final StoreMapper mapper;
  final RxList _storeList = <Store>[].obs;
  final _store = Store(0, "", "", "", "", 0, 0, "").obs;
  final RxList _facility = <Facility>[].obs;
  final RxList _category = <Category>[].obs;
  final RxList _menu = <MenuList>[].obs;
  final RxList _workDay = <WorkDay>[].obs;
  final RxList _storeDto = <StoreDto>[].obs;
  final RxList _searchList = <StoreDto>[].obs;

  final RxList _hotPlace = <StoreDto>[].obs;
  final RxInt currentIndex = 0.obs;

  StoreController({required this.mapper});

  get storeList => _storeList.value;

  set storeList(value) => _storeList.value = value;

  get store => _store.value;

  set store(value) => _store.value = value;

  get facility => _facility.value;

  set facility(value) => _facility.value = value;

  get category => _category.value;

  set category(value) => _category.value = value;

  get menu => _menu.value;

  set menu(value) => _menu.value = value;

  get workDay => _workDay.value;

  set workDay(value) => _workDay.value = value;

  get storeDto => _storeDto.value;

  set storeDto(value) => _storeDto.value = value;

  get searchList => _searchList.value;

  set searchList(value) => _searchList.value = value;

  get hotPlace => _hotPlace.value;

  set hotPlace(value) => _hotPlace.value = value;

  @override
  void onInit() async {
    super.onInit();
    isLoading.value = true;
    await getStoresOrderByReviewCount();
    isLoading.value = false;

    userController = Get.find<UserController>();
    themeController = Get.find<ThemeController>();
    reviewController = Get.find<ReviewController>();
    likeStoreController = Get.find<LikeStoreController>();
    imageController = Get.find<ImageController>();
    searchController = Get.find<SearchController>();

    getAllStoresWithCategory();
  }

  getStoreAll() async {
    return await mapper.getAll().then((data) {
      storeList = data;
    });
  }

  getAllStoresWithCategory() async {
    return await mapper.getAllStoresWithCategory().then((data) {
      storeDto = data;
    });
  }

  getStoresByCategoryId(int categoryId) async {
    return await mapper.getStoresByCategoryId(categoryId).then((data) {
      storeDto = data;
    });
  }

  getStoreById(int id) async {
    return await mapper.getStoreById(id).then((data) {
      store = data;
    });
  }

  getFacilityByStoreId(int id) async {
    return await mapper.getFacilityByStoreId(id).then((data) {
      facility = data;
    });
  }

  getCategoryByStoreId(int id) async {
    return await mapper.getCategoryByStoreId(id).then((data) {
      category = data;
    });
  }

  getMenuByStoreId(int id) async {
    return await mapper.getMenuByStoreId(id).then((data) {
      menu = data;
    });
  }

  getWorkDayByStoreId(int id) async {
    return await mapper.getWorkDayByStoreId(id).then((data) {
      workDay = data;
    });
  }

  updateRating(int id) async {
    await mapper.updateRating(id);
  }

  filterStoresByCategory(int categoryId) async {
    return await mapper.filterStoresByCategory(categoryId).then((data) {
      storeList = data;
    });
  }

  getStoresOrderByReviewCount() async {
    return await mapper.getStoresOrderByReviewCount().then((data) {
      hotPlace = data;
    });
  }

  searchStoreName(String storeName) async {
    return await searchController.searchStoreName(storeName).then((data) {
      searchList = data;
    });
  }
}
