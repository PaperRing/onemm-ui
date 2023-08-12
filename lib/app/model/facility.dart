class Facility {
  final int _id;
  final String _name;
  final int _storeId;

  Facility(this._id, this._name, this._storeId);

  factory Facility.empty() => Facility(0, "", 0);

  int get id => _id;

  String get name => _name;

  int get storeId => _storeId;

  Facility.fromJson(Map<String, dynamic> json)
      : _id = json['id'],
        _name = json['name'],
        _storeId = json['store_id'];
}
