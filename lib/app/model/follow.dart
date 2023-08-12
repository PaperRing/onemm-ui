class Follow {
  int? _id;
  final int _loginId;
  final int _followingId;

  Follow(this._loginId, this._followingId);

  int? get id => _id;

  int get loginId => _loginId;

  int get followingId => _followingId;

  Follow.fromJson(Map<String, dynamic> json)
      : _id = json['id'],
        _loginId = json['loginId'],
        _followingId = json['followingId'];

  Map<String, dynamic> toJson() => {
        "id": _id,
        "loginId": _loginId,
        "followingId": _followingId,
      };
}
