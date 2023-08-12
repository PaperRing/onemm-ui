class ThemeItem {
  final int _themeId;
  final int _storeId;
  String? _storeName;
  int? _userId;
  String? _userName;
  String? _title;
  String? _description;
  double? _averageRating;

  ThemeItem(this._themeId, this._storeId);

  int get themeId => _themeId;

  int get storeId => _storeId;

  int? get userId => _userId;

  String? get title => _title;

  String? get description => _description;

  String? get storeName => _storeName;

  String? get userName => _userName;

  double? get averageRating => _averageRating;

  ThemeItem.fromJson(Map<String, dynamic> json)
      : _themeId = json['id'],
        _storeId = json['store_id'],
        _storeName = json['store_name'],
        _userId = json['user_id'],
        _userName = json['user_name'],
        _title = json['title'],
        _description = json['description'],
        _averageRating = json['average_rating'];


  Map<String, dynamic> toJson() => {"themeId": _themeId, "storeId": _storeId};
}
