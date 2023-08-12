import 'dart:core';

class LikeStoreDto {
  final int _userId;
  final int _storeId;
  final bool _likeBool;

  LikeStoreDto(this._userId, this._storeId, this._likeBool);

  int get userId => _userId;

  int get storeId => _storeId;

  bool get likeBool => _likeBool;

  Map<String, dynamic> toJson() => {
        "storeId": _storeId,
        "userId": _userId,
        "bool": _likeBool,
      };
}
