import 'dart:convert';

import 'package:get/get_connect/connect.dart';
import 'package:onemm/app/config/host_config.dart';

import '../component/http.dart';
import '../model/like_store.dart';

class LikeStoreMapper extends GetConnect {
  var url = "${HostConfig.host}/like";

  addLike(Map<String, dynamic> likeStore) async {
    await Http.I.post(
      "$url/add",
      body: jsonEncode(likeStore),
      header: {'Content-Type': 'application/json'},
      decode: false,
    );
  }

  deleteLike(int userId, int storeId) async{
    await Http.I.delete(
      "$url/delete?userId=$userId&storeId=$storeId",
      header: {'Content-Type': 'application/json'},
      decode: false,
    );
  }

  getLikeByStore(int userId, int storeId) async{
    var response =  await Http.I.get("$url/get/store/$userId/$storeId", decode: true);
    LikeStore likeStore = LikeStore.fromJson(response);
    return likeStore;
  }

  getLikeByUser(int userId) async{
    List<dynamic> response =  await Http.I.get("$url/get/all/$userId", decode: true);
    List likeStore = response.map((json) => LikeStore.fromMap(json)).toList();
    return likeStore;
  }

}
