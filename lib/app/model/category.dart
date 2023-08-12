class Category {
  final int? _id;
  final String? _name;
  final int? _storeId;

  Category(this._id, this._name, this._storeId);

  factory Category.empty() => Category(0, "", 0);

  int? get id => _id;

  String? get name => _name;

  int? get storeId => _storeId;

  Category.fromJson(Map<String, dynamic> json)
      : _id = json['id'],
        _name = json['name'],
        _storeId = json['store_id'];
}
