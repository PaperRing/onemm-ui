class MenuList{
  final int? _id;
  final int? _storeId;
  final String? _name;
  final String? _price;

  MenuList(this._id, this._storeId, this._name, this._price);

  int? get id => _id;

  int? get storeId => _storeId;

  String? get name => _name;

  String? get price => _price;

  MenuList.fromJson(Map<String, dynamic> json)
      : _id = json['id'],
        _storeId = json['store_id'],
        _name = json['name'],
        _price = json['price'];

}