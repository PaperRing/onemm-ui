import 'dart:convert';

import 'package:get/get_connect/connect.dart';

import '../component/http.dart';
import '../config/host_config.dart';
import '../controller/dto/store_dto.dart';
import '../model/search.dart';

class SearchMapper extends GetConnect {
  var url = "${HostConfig.host}/search";

  searchStoreName(String storeName) async {
    List<dynamic> response = await Http.I.get("$url/name/$storeName", decode: true);
    List storeDto = response.map((json) => StoreDto.fromJson(json)).toList();
    return storeDto;
  }

  saveSearchRecord(Map<String, dynamic> record) async {
    await Http.I.post(
      "$url/save",
      body: jsonEncode(record),
      header: {'Content-Type': 'application/json'},
      decode: false,
    );
  }

  getSearchRecord(int userId) async {
    List<dynamic> response = await Http.I.get("$url/get/$userId", decode: true);
    List search = response.map((json) => Search.fromJson(json)).toList();
    return search;
  }

  deleteRecord(int id) async {
    await Http.I.delete(
      "$url/delete/$id",
      header: {'Content-Type': 'application/json'},
      decode: false,
    );
  }
}
