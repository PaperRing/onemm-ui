class LikeTheme {
  int? _id;
  final int _userId;
  final int _themeId;
  final bool _likeBool;
  int? _themeOwnerId;
  String? _title;
  String? _description;
  bool? _share;
  String? _updatedAt;
  String? _userName;
  bool? _s3;
  String? _photoUrl;

  LikeTheme(this._userId, this._themeId, this._likeBool);

  int? get id => _id;

  int get userId => _userId;

  int get themeId => _themeId;

  int? get themeOwnerId => _themeOwnerId;

  bool? get likeBool => _likeBool;

  bool? get share => _share;

  String? get title => _title;

  String? get description => _description;

  String? get updatedAt => _updatedAt;

  String? get userName => _userName;

  bool? get s3 => _s3;

  String? get photoUrl => _photoUrl;

  Map<String, dynamic> toJson() => {
        "userId": _userId,
        "themeId": _themeId,
        "bool": _likeBool,
      };

  LikeTheme.fromMap(Map<String, dynamic> json)
      : _id = json['id'],
        _userId = json['userId'],
        _themeId = json['themeId'],
        _likeBool = json['bool'];

  LikeTheme.fromJson(Map<String, dynamic> json)
      : _id = json['id'],
        _userId = json['user_id'],
        _themeId = json['theme_id'],
        _themeOwnerId = json['theme_owner_id'],
        _likeBool = json['bool'],
        _title = json['title'],
        _description = json['description'],
        _share = json['share'],
        _updatedAt = json['update_at'],
        _userName = json['user_name'],
        _s3 = json['s3'],
        _photoUrl = json['photo_url'] ?? "";
}
