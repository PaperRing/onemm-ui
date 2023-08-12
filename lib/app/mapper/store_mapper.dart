import 'package:get/get.dart';
import 'package:onemm/app/component/http.dart';
import 'package:onemm/app/model/facility.dart';

import '../config/host_config.dart';
import '../controller/dto/store_dto.dart';
import '../model/category.dart';
import '../model/menu.dart';
import '../model/store.dart';
import '../model/workday.dart';

class StoreMapper extends GetConnect {
  var url = "${HostConfig.host}/stores";

  getAll() async {
    List<dynamic> response = await Http.I.get(url, decode: true);
    List storeList = response.map((json) => Store.fromJson(json)).toList();
    return storeList;
  }

  getStoreById(int id) async {
    var response = await Http.I.get("$url/id/$id", decode: true);
    Store store = Store.fromJson(response);
    print(store.id);
    return store;
  }

  getFacilityByStoreId(int id) async {
    List<dynamic> response = await Http.I.get("$url/fac/$id", decode: true);
    List facilityList = response.map((json) => Facility.fromJson(json)).toList();
    return facilityList;
  }

  getCategoryByStoreId(int id) async {
    List<dynamic> response = await Http.I.get("$url/category/$id", decode: true);
    List categoryList = response.map((json) => Category.fromJson(json)).toList();
    return categoryList;
  }

  getMenuByStoreId(int id) async {
    List<dynamic> response = await Http.I.get("$url/menu/$id", decode: true);
    List menuList = response.map((json) => MenuList.fromJson(json)).toList();
    return menuList;
  }

  getWorkDayByStoreId(int id) async {
    List<dynamic> response = await Http.I.get("$url/menu/$id", decode: true);
    List workDayList = response.map((json) => WorkDay.fromJson(json)).toList();
    return workDayList;
  }

  getAllStoresWithCategory() async {
    List<dynamic> response = await Http.I.get("$url/all/category", decode: true);
    List storeDto = response.map((json) => StoreDto.fromJson(json)).toList();
    return storeDto;
  }

  updateRating(int id) async {
    await Http.I.update(
      "$url/update/rating/$id",
      decode: false,
    );
  }

  filterStoresByCategory(int categoryId) async {
    List<dynamic> response = await Http.I.get("$url/filter/category/$categoryId", decode: true);
    List storeList = response.map((json) => Store.fromJson(json)).toList();
    return storeList;
  }

  getStoresByCategoryId(int categoryId) async {
    List<dynamic> response = await Http.I.get("$url/filter/$categoryId", decode: true);
    List storeDto = response.map((json) => StoreDto.fromJson(json)).toList();
    return storeDto;
  }

  getStoresOrderByReviewCount() async {
    List<dynamic> response = await Http.I.get("$url/review-count-order", decode: true);
    List storeDto = response.map((json) => StoreDto.fromJson(json)).toList();
    return storeDto;
  }

}
