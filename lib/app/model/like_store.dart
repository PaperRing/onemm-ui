import 'dart:core';

class LikeStore {
  final int _id;
  final int _userId;
  final int _storeId;
  final bool _likeBool;
  String? _storeName;
  String? _category;
  double? _averageRating;

  LikeStore(this._id, this._userId, this._storeId, this._likeBool);

  // factory LikeStore.empty() => LikeStore(0, 0, 0, "");

  int? get id => _id;

  int get userId => _userId;

  int get storeId => _storeId;

  bool? get likeBool => _likeBool;

  String? get storeName => _storeName;

  String? get category => _category;

  double? get averageRating => _averageRating;

  LikeStore.fromMap(Map<String, dynamic> json)
      : _id = json['id'],
        _userId = json['user_id'],
        _storeId = json['store_id'],
        _likeBool = json['bool'],
        _storeName = json['store_name'],
        _category = json['category'],
        _averageRating = json['average_rating'] ?? 0;

  LikeStore.fromJson(Map<String, dynamic> json)
      : _id = json['id'],
        _userId = json['userId'],
        _storeId = json['storeId'],
        _likeBool = json['bool'];
}
