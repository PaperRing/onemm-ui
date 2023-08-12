class FollowDto {
  final int _id;
  final int _loginId;
  final int _followingId;
  final String _userName;
  final String? _photoUrl;
  final bool _s3;


  FollowDto(this._id, this._loginId, this._followingId,  this._userName, this._photoUrl, this._s3);

  int get id => _id;

  int get loginId => _loginId;

  int get followingId => _followingId;

  String get userName => _userName;

  String? get photoUrl => _photoUrl;

  bool get s3 => _s3;


  FollowDto.fromJson(Map<String, dynamic> json)
      : _id = json['id'],
        _loginId = json['login_id'],
        _followingId = json['following_id'],
        _userName = json['user_name'],
        _photoUrl = json['photo_url'] ,
        _s3 = json['s3'];

}
