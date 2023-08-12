import 'dart:convert';

import 'package:get/get.dart';
import 'package:onemm/app/controller/dto/follow_dto.dart';

import '../component/http.dart';
import '../config/host_config.dart';
import '../model/follow.dart';
import '../model/user_db.dart';

class UserMapper extends GetConnect {
  var url = "${HostConfig.host}/user";
  var userExist = false;

  saveUser(Map<String, dynamic> map) async {
    await Http.I.post(
      "$url/save",
      decode: false,
      body: jsonEncode(map),
      header: {'Content-Type': 'application/json'},
    );
  }

  findUser(String uid) async {
    var response = await Http.I.get("$url/get", query: {"uid": uid}, decode: true);
    UserDB user = UserDB.fromJson(response);
    return user;
  }

  updateUser(String userId, Map<String, dynamic> map) async {
    await Http.I.update(
      "$url/update?uid=$userId",
      header: {'Content-Type': 'application/json'},
      body: jsonEncode(map),
      decode: false,
    );
  }

  deleteUserDb(int id) async {
    await Http.I.delete("$url/delete/$id", decode: false);
  }

  addFollow(Map<String, dynamic> follow) async {
    await Http.I.post(
      "$url/follow",
      decode: false,
      body: jsonEncode(follow),
      header: {'Content-Type': 'application/json'},
    );
  }

  getFollower(int loginId) async {
    List<dynamic> response = await Http.I.get("$url/follower/$loginId", decode: true);
    List follower = response.map((json) => FollowDto.fromJson(json)).toList();
    return follower;
  }

  getFollowing(int loginId) async {
    List<dynamic> response = await Http.I.get("$url/following/$loginId", decode: true);
    List follower = response.map((json) => FollowDto.fromJson(json)).toList();
    return follower;
  }

  deleteFollow(int loginId, int followingId) async {
    await Http.I.delete("$url/follow/delete/$loginId/$followingId", decode: false);
  }

  getFollowOne(int loginId, int followingId) async {
    var response = await Http.I.get("$url/get/follow/$loginId/$followingId", decode: true);
    Follow follow = Follow.fromJson(response);
    return follow;
  }

  getOtherUserInfo(int id) async {
    var response = await Http.I.get("$url/get/other/$id", decode: true);
    UserDB userDB = UserDB.fromJson(response);
    return userDB;
  }

  addBlockUser(Map<String, dynamic> blockUser) async {
    await Http.I.post(
      "$url/block/add",
      decode: false,
      body: jsonEncode(blockUser),
      header: {'Content-Type': 'application/json'},
    );
  }
}
