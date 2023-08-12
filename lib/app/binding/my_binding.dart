import 'package:get/get.dart';
import 'package:onemm/app/controller/image_controller.dart';
import 'package:onemm/app/controller/like_store_controller.dart';
import 'package:onemm/app/controller/review_controller.dart';
import 'package:onemm/app/controller/search_controller.dart';
import 'package:onemm/app/controller/theme_controller.dart';
import 'package:onemm/app/controller/user_controller.dart';
import 'package:onemm/app/mapper/like_store_mapper.dart';
import 'package:onemm/app/mapper/review_mapper.dart';
import 'package:onemm/app/mapper/store_mapper.dart';
import 'package:onemm/app/mapper/theme_mapper.dart';

import '../controller/store_controller.dart';
import '../mapper/image_mapper.dart';
import '../mapper/search_mapper.dart';
import '../mapper/user_mapper.dart';

class MyBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StoreController(mapper: StoreMapper()));
    Get.lazyPut(() => ReviewController(reviewMapper: ReviewMapper()));
    Get.lazyPut(() => UserController(userMapper: UserMapper()));
    Get.lazyPut(() => LikeStoreController(likeStoreMapper: LikeStoreMapper()));
    Get.lazyPut(() => ImageController(imageMapper: ImageMapper()));
    Get.lazyPut(() => ThemeController(themeMapper: ThemeMapper()));
    Get.lazyPut(() => SearchController(searchMapper: SearchMapper()));

  }
}
