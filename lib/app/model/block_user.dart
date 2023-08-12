class BlockUser {
  int? _id;
  final int _blockUserId;
  final int _userId;

  BlockUser(this._blockUserId, this._userId);

  int? get id => _id;

  int? get storeId => _blockUserId;

  int? get userId => _userId;

  BlockUser.fromJson(Map<String, dynamic> json)
      : _id = json['id'],
        _blockUserId = json['block_user_id'],
        _userId = json['user_id'];

  Map<String, dynamic> toJson() => {
        "userId": _userId,
        "blockUserId": _blockUserId,
      };
}
