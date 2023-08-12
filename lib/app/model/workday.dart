class WorkDay {
  final int? _id;
  final int? _storeId;
  final String? _day;
  final String? _time;

  WorkDay(this._id, this._storeId, this._day, this._time);

  factory WorkDay.empty() => WorkDay(0, 0, "", "");

  int? get id => _id;

  int? get storeId => _storeId;

  String? get day => _day;

  String? get time => _time;

  WorkDay.fromJson(Map<String, dynamic> json)
      : _id = json['id'],
        _storeId = json['store_id'],
        _day = json['day'],
        _time = json['time'];
}
