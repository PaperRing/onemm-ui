class Report {
  int? _id;
  final int _reviewId;
  final int _userId;

  Report(this._reviewId, this._userId);

  int? get id => _id;

  int get storeId => _reviewId;

  int get userId => _userId;

  Report.fromJson(Map<String, dynamic> json)
      : _id = json['id'],
        _reviewId = json['review_id'],
        _userId = json['user_id'];

  Map<String, dynamic> toJson() => {
        "userId": _userId,
        "reviewId": _reviewId,
      };
}
