class ReviewDto {
  int? _id;
  int _storeId;
  int _userId;
  String _content;
  double _rating;
  bool _s3;

  ReviewDto(this._storeId, this._userId, this._content, this._rating, this._s3);

  int? get id => _id;

  int get storeId => _storeId;

  int get userId => _userId;

  String get content => _content;

  double get rating => _rating;

  bool get s3 => _s3;

  set storeId(int value) => _storeId = value;

  set userId(int value) => _userId = value;

  set content(String value) => _content = value;

  set rating(double value) => _rating = value;

  set s3(bool value) => _s3 = value;

  ReviewDto.fromJson(Map<String, dynamic> json)
      : _id = json['id'],
        _storeId = json['storeId'],
        _userId = json['userId'],
        _content = json['content'],
        _rating = json['rating'],
        _s3 = json['s3'];

  Map<String, dynamic> toJson() => {
        "storeId": _storeId,
        "userId": _userId,
        "content": _content,
        "rating": _rating,
        "s3": _s3,
      };
}
