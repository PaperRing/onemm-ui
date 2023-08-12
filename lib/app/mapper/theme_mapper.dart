import 'dart:convert';

import 'package:get/get.dart';
import 'package:onemm/app/model/like_theme.dart';
import 'package:onemm/app/model/theme_item.dart';

import '../component/http.dart';
import '../config/host_config.dart';
import '../model/theme_list.dart';

class ThemeMapper extends GetConnect {
  var url = "${HostConfig.host}/theme";
  List result = <ThemeItem>[];

  getThemeListAll(userId) async {
    List<dynamic> response = await Http.I.get("$url/get/all/$userId", decode: true);
    List themeList = response.map((json) => ThemeList.fromJson(json)).toList();
    return themeList;
  }

  getThemeListAllByUser(int userId) async {
    List<dynamic> response = await Http.I.get("$url/get/by/$userId", decode: true);
    List themeList = response.map((json) => ThemeList.fromJson(json)).toList();
    return themeList;
  }

  addThemeList(Map<String, dynamic> themeList) async {
    await Http.I.post(
      "$url/add/list",
      body: jsonEncode(themeList),
      header: {'Content-Type': 'application/json'},
      decode: false,
    );
  }

  addThemeItem(Map<String, dynamic> themeItem) async {
    await Http.I.post(
      "$url/add/item",
      body: jsonEncode(themeItem),
      header: {'Content-Type': 'application/json'},
      decode: false,
    );
  }

  getThemeListItems(int id, int userId) async {
    List<dynamic> response = await Http.I.get("$url/get/one?id=$id&userId=$userId", decode: true);
    List themeListItem = response.map((json) => ThemeItem.fromJson(json)).toList();
    return themeListItem;
  }

  getThemeItems(int id) async {
    List<dynamic> response = await Http.I.get("$url/get/one/$id", decode: true);
    List themeListItem = response.map((json) => ThemeItem.fromJson(json)).toList();
    return themeListItem;
  }

  addThemeListLike(Map<String, dynamic> likeTheme) async {
    await Http.I.post(
      "$url/like/add",
      body: jsonEncode(likeTheme),
      header: {'Content-Type': 'application/json'},
      decode: false,
    );
  }

  getLikeThemeList(int userId) async {
    List<dynamic> response = await Http.I.get("$url/like/get/$userId", decode: true);
    List likeTheme = response.map((json) => LikeTheme.fromJson(json)).toList();
    return likeTheme;
  }

  deleteThemeListLike(int userId, int themeId) async {
    await Http.I.delete(
      "$url/like/delete?userId=$userId&themeId=$themeId",
      header: {'Content-Type': 'application/json'},
      decode: false,
    );
  }

  getLikeOneTheme(int userId, int themeId) async {
    var response = await Http.I.get("$url/like/get/one/$userId/$themeId", decode: true);
    LikeTheme likeStore = LikeTheme.fromMap(response);
    return likeStore;
  }

  deleteThemeList(int id) async {
    await Http.I.delete(
      "$url/delete/list/$id",
      header: {'Content-Type': 'application/json'},
      decode: false,
    );
  }

  deleteThemeItem(int themeId, int storeId) async {
    await Http.I.delete(
      "$url/delete/item?themeId=$themeId&storeId=$storeId",
      header: {'Content-Type': 'application/json'},
      decode: false,
    );
  }

  getOneThemeList(int themeId) async {
    var response = await Http.I.get("$url/get/one/list/$themeId", decode: true);
    ThemeList themeList = ThemeList.fromJsonDetail(response);
    return themeList;
  }

  updateThemeList(int id, Map<String, dynamic> theme) async {
    await Http.I.update(
      "$url/update/$id",
      header: {'Content-Type': 'application/json'},
      body: jsonEncode(theme),
      decode: false,
    );
  }
}
