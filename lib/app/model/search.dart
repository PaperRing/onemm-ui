class Search {
  late int _id;
  final int _userId;
  final String _record;

  Search(this._userId, this._record);

  int get id => _id;

  int get userId => _userId;

  String get record => _record;

  Search.fromJson(Map<String, dynamic> json)
      : _id = json['id'],
        _userId = json['user_id'],
        _record = json['record'];

  Map<String, dynamic> toJson() => {
        "userId": _userId,
        "record": _record,
      };
}
