class ThemeList {
  int? _id;
  final int _userId;
  final String _title;
  final String? _description;
  final bool _share;
  String? _updatedAt;
  String? _userName;
  bool? _s3;
  String? _photoUrl;

  ThemeList(this._userId, this._title, this._description, this._share);

  int? get id => _id;

  int get userId => _userId;

  bool get share => _share;

  String get title => _title;

  String? get description => _description;

  String? get updatedAt => _updatedAt;

  String? get userName => _userName;

  bool? get s3 => _s3;

  String? get photoUrl => _photoUrl;

  ThemeList.fromJson(Map<String, dynamic> json)
      : _id = json['id'],
        _userId = json['user_id'],
        _title = json['title'],
        _description = json['description'],
        _share = json['share'],
        _updatedAt = json['update_at'],
        _userName = json['user_name'],
        _s3 = json['s3'],
        _photoUrl = json['photo_url'] ?? "";

  ThemeList.fromJsonMyPage(Map<String, dynamic> json)
      : _id = json['id'],
        _userId = json['user_id'],
        _title = json['title'],
        _description = json['description'],
        _share = json['share'],
        _updatedAt = json['update_at'],
        _s3 = json['s3'],
        _photoUrl = json['photo_url'] ?? "";

  ThemeList.fromJsonDetail(Map<String, dynamic> json)
      : _id = json['id'],
        _userId = json['userId'],
        _title = json['title'],
        _description = json['description'],
        _share = json['share'],
        _s3 = json['s3'],
        _photoUrl = json['photo_url'] ?? "";

  Map<String, dynamic> toJson() => {
        "userId": _userId,
        "title": _title,
        "description": _description,
        "share": _share,
      };
}
