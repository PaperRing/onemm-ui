class FollowerDto {
  int? _id;
  int? _loginId;
  int? _followingId;
  bool? _followBool = false;
  String? _userName;
  String? _photoUrl;
  bool? _s3;

  int? get id => _id;

  int? get loginId => _loginId;

  int? get followingId => _followingId;

  bool? get followBool => _followBool;

  String? get userName => _userName;

  String? get photoUrl => _photoUrl;

  bool? get s3 => _s3;

  set id(int? id) => _id = id;

  set loginId(int? loginId) => _loginId = loginId;

  set followingId(int? followingId) => _followingId = followingId;

  set followBool(bool? followBool) => _followBool = followBool!;

  set userName(String? userName) => _userName = userName;

  set photoUrl(String? photoUrl) => _photoUrl = photoUrl;

  set s3(bool? s3) => _s3 = s3!;
}
