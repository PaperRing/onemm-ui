import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:onemm/app/controller/dto/follower_dto.dart';
import 'package:onemm/app/controller/image_controller.dart';
import 'package:onemm/app/controller/theme_controller.dart';

import '../component/google_auth.dart';
import '../mapper/user_mapper.dart';
import '../model/follow.dart';
import '../model/user_db.dart';
import 'dto/follow_dto.dart';

class UserController extends GetxController {
  late ImageController imageController;
  late ThemeController themeController;

  final UserMapper userMapper;
  FirebaseAuth _auth = FirebaseAuth.instance;
  final _uid = ''.obs;
  final _photoUrl = ''.obs;
  final _user = UserDB("", "", "", "", false).obs;
  final _followOne = Follow(0, 0).obs;
  final _otherUserInfo = UserDB("", "", "", "", false).obs;
  final RxList _myFollower = <FollowDto>[].obs;
  final RxList _myFollowing = <FollowDto>[].obs;
  final RxList _otherFollower = <FollowDto>[].obs;
  final RxList _otherFollowing = <FollowDto>[].obs;

  RxList _myFollowerDto = <FollowerDto>[].obs;
  RxList _myFollowingDto = <FollowerDto>[].obs;
  RxList _otherFollowDto = <FollowerDto>[].obs;
  RxBool followBool = false.obs;
  RxBool themeFollowBool = false.obs;
  int? userId = 0;

  UserController({required this.userMapper});

  get uid => _uid.value;

  set uid(value) => _uid.value = value;

  get photoUrl => _photoUrl.value;

  set photoUrl(value) => _photoUrl.value = value;

  get user => _user.value;

  set user(value) => _user.value = value;

  get myFollower => _myFollower.value;

  set myFollower(value) => _myFollower.value = value;

  get myFollowing => _myFollowing.value;

  set myFollowing(value) => _myFollowing.value = value;

  get otherFollower => _otherFollower.value;

  set otherFollower(value) => _otherFollower.value = value;

  get otherFollowing => _otherFollowing.value;

  set otherFollowing(value) => _otherFollowing.value = value;

  get followOne => _followOne.value;

  set followOne(value) => _followOne.value = value;

  get otherUserInfo => _otherUserInfo.value;

  set otherUserInfo(value) => _otherUserInfo.value = value;

  get myFollowerDto => _myFollowerDto.value;

  set myFollowerDto(value) => _myFollowerDto.value = value;

  get myFollowingDto => _myFollowingDto.value;

  set myFollowingDto(value) => _myFollowingDto.value = value;

  get otherFollowDto => _otherFollowDto.value;

  set otherFollowDto(value) => _otherFollowDto.value = value;

  @override
  void onInit() async {
    super.onInit();
    themeController = Get.find<ThemeController>();
    imageController = Get.find<ImageController>();
    await getCurrentUser();

    await themeController.getThemeListAll(user.id == null ? 0 : user.id);
  }

  getCurrentUser() async {
    if (_auth.currentUser != null) {
      uid = _auth.currentUser!.uid;
      await findUser(uid);
      await getPhoto();
    }
  }

  getPhoto() async {
    if (await _auth.currentUser?.photoURL != null) {
      _photoUrl.value = _auth.currentUser!.photoURL!;
    }
  }

  findUser(String uid) async {
    user = await userMapper.findUser(uid);
    print(user);
    userId = user.id;
  }

  saveUser(Map<String, dynamic> user) async {
    await userMapper.saveUser(user);
  }

  getOtherUserInfo(int id) async {
    otherUserInfo = await userMapper.getOtherUserInfo(id);
  }

  deleteUser() async {
    try {
      await FirebaseAuth.instance.currentUser?.delete();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        print('The user must reauthenticate before this operation can be executed.');
      }
    }
  }

  logOut() async {
    await GoogleAuth.logout();
    uid = '';
    print(uid);
  }

  deleteUserDB(int id) async {
    await userMapper.deleteUserDb(id);
  }

  updateUser(String userId, Map<String, dynamic> map) async {
    await userMapper.updateUser(userId, map);
  }

  addFollow(Map<String, dynamic> follow) async {
    await userMapper.addFollow(follow);
  }

  deleteFollow(int loginId, int followingId) async {
    await userMapper.deleteFollow(loginId, followingId);
  }

  //나를 팔로우 하는 사람
  getMyFollower(int loginId) async {
    return await userMapper.getFollower(loginId).then((data) {
      myFollower = data;
    });
  }

  //내가 팔로우 하는 사람
  getMyFollowing(int loginId) async {
    return await userMapper.getFollowing(loginId).then((data) {
      myFollowing = data;
    });
  }

  getOtherFollower(int loginId) async {
    return await userMapper.getFollower(loginId).then((data) {
      otherFollower = data;
    });
  }

  getOtherFollowing(int loginId) async {
    return await userMapper.getFollowing(loginId).then((data) {
      otherFollowing = data;
    });
  }

  getFollowOne(int loginId, int followingId) async {
    followOne = await userMapper.getFollowOne(loginId, followingId);
  }

  addBlockUser(Map<String, dynamic> blockUser) async {
    await userMapper.addBlockUser(blockUser);
  }

  checkFollower() {
    for (var i in myFollower) {
      FollowerDto dto = FollowerDto();

      for (var j in myFollowing) {
        if (i.loginId == j.followingId) {
          dto.followBool = true;
          print("true");
        }
      }
      dto.id = i.id;
      dto.loginId = i.loginId;
      dto.followingId = i.followingId;
      dto.photoUrl = i.photoUrl;
      dto.userName = i.userName;
      dto.s3 = i.s3;
      myFollowerDto.add(dto);
    }
  }

  checkFollowing() {
    for (var i in myFollowing) {
      FollowerDto dto = FollowerDto();
      dto.id = i.id;
      dto.loginId = i.loginId;
      dto.followingId = i.followingId;
      dto.photoUrl = i.photoUrl;
      dto.userName = i.userName;
      dto.s3 = i.s3;
      dto.followBool = true;
      myFollowingDto.add(dto);
    }
  }

  checkOtherUserFollower(follow, myFollow) async {
    if (userId == 0) {
      for (var i in follow) {
        FollowerDto dto = FollowerDto();
        dto.id = i.id;
        dto.loginId = i.loginId;
        dto.followingId = i.followingId;
        dto.photoUrl = i.photoUrl;
        dto.userName = i.userName;
        dto.s3 = i.s3;
        dto.followBool = false;
        otherFollowDto.add(dto);
      }
    } else {
      for (var i in follow) {
        FollowerDto dto = FollowerDto();
        for (var j in myFollow) {
          if (i.loginId == j.followingId) {
            dto.followBool = true;
          }
        }
        dto.id = i.id;
        dto.loginId = i.loginId;
        dto.followingId = i.followingId;
        dto.photoUrl = i.photoUrl;
        dto.userName = i.userName;
        dto.s3 = i.s3;
        otherFollowDto.add(dto);
      }
    }
  }

  checkOtherUserFollowing(follow, myFollow) async {
    if (userId == 0) {
      for (var i in follow) {
        FollowerDto dto = FollowerDto();
        dto.id = i.id;
        dto.loginId = i.loginId;
        dto.followingId = i.followingId;
        dto.photoUrl = i.photoUrl;
        dto.userName = i.userName;
        dto.s3 = i.s3;
        dto.followBool = false;
        otherFollowDto.add(dto);
      }
    } else {
      for (var i in follow) {
        FollowerDto dto = FollowerDto();
        for (var j in myFollow) {
          if (i.followingId == j.followingId) {
            dto.followBool = true;
          }
        }
        dto.id = i.id;
        dto.loginId = i.loginId;
        dto.followingId = i.followingId;
        dto.photoUrl = i.photoUrl;
        dto.userName = i.userName;
        dto.s3 = i.s3;
        otherFollowDto.add(dto);
      }
    }
  }
}
