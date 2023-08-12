class Review {
  final int? _id;
  final int? _storeId;
  final String? _storeName;
  final int? _userId;
  final String? _content;
  final double? _rating;
  final String _createdAt;
  final String _updatedAt;
  final String? _userName;
  final String? _photoUrl;
  final bool? _s3;
  final bool? _reviewS3;

  Review(this._id, this._storeId, this._userId, this._content, this._createdAt, this._updatedAt, this._rating, this._userName, this._photoUrl, this._storeName, this._s3, this._reviewS3);

  int? get id => _id;

  int? get storeId => _storeId;

  int? get userId => _userId;

  String? get content => _content;

  String get createdAt => _createdAt;

  String get updatedAt => _updatedAt;

  double? get rating => _rating;

  String? get userName => _userName;

  String? get photoUrl => _photoUrl;

  String? get storeName => _storeName;

  bool? get s3 => _s3;

  bool? get reviewS3 => _reviewS3;

  Review.fromJson(Map<String, dynamic> json)
      : _id = json['id'],
        _storeId = json['store_id'],
        _storeName = json['store_name'],
        _userId = json['user_id'],
        _content = json['content'] ?? "",
        _createdAt = json['create_at'],
        _updatedAt = json['update_at'],
        _rating = json['rating'],
        _userName = json['user_name'],
        _photoUrl = json['photo_url'] ?? "",
        _s3 = json['s3'],
        _reviewS3 = json['review_s3'];

  Map<String, dynamic> toJson() => {
        "store_id": _storeId,
        "user_id": _userId,
        "content": _content,
        "rating": _rating,
      };
}
