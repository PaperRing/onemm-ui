class StoreDto {
  final int? _id;
  final String? _name;
  final String? _address;
  final String? _category;
  final double? _averageRating;
  final int? _count;
  final String _dong;

  StoreDto(this._id, this._name, this._address, this._category, this._averageRating, this._count, this._dong);

  int? get id => _id;

  String? get name => _name;

  String? get address => _address;

  String? get category => _category;

  double? get averageRating => _averageRating;

  int? get count => _count;

  String get dong => _dong;

  StoreDto.fromJson(Map<String, dynamic> json)
      : _id = json['id'],
        _name = json['name'],
        _address = json['address'],
        _category = json['category'],
        _averageRating = json['average_rating'] ?? 0,
        _count = json['count'] ?? 0,
        _dong = json['dong'] ?? '';

  Map<String, dynamic> toJson() => {
        "id": _id,
        "name": _name,
        "address": _address,
        "category": _category,
        "average_rating": _averageRating,
      };
}
