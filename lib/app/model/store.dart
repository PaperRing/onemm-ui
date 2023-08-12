class Store {
  final int _id;
  final String _name;
  final String _address;
  final String _tel;
  final String _homepage;
  final double? _averageRating;
  final int? _count;
  final String _dong;

  Store(this._id, this._name, this._address, this._tel, this._homepage, this._averageRating, this._count, this._dong);

  factory Store.empty() => Store(0, "", "", "", "", 0, 0, "");

  int get id => _id;

  String get name => _name;

  String get address => _address;

  String get tel => _tel;

  String get homepage => _homepage;

  double? get averageRating => _averageRating;

  int? get count => _count;

  String get dong => _dong;

  Store.fromJson(Map<String, dynamic> json)
      : _id = json['id'],
        _name = json['name'],
        _address = json['address'],
        _tel = json['tel'],
        _homepage = json['homepage'],
        _averageRating = json['averageRating'] ?? 0,
        _count = json['count'] ?? 0,
        _dong = json['dong'];

  Map<String, dynamic> toJson() => {
        "id": _id,
        "name": _name,
        "address": _address,
        "tel": _tel,
        "homepage": _homepage,
        "average_rating": _averageRating,
        "count": _count,
        "dong": _dong,
      };
}
