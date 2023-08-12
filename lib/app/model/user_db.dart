class UserDB {
   int? _id;
  final String? _uid;
  final String? _name;
  final String? _photoUrl;
  final bool? _s3;
  final String? _location;

  UserDB(this._uid, this._name, this._photoUrl, this._location, this._s3);

  // factory UserDB.empty() => UserDB(0, "", "", "", "", false);

  int? get id => _id;

  String? get uid => _uid;

  String? get name => _name;

  String? get photoUrl => _photoUrl;

  bool? get s3 => _s3;

  String? get location => _location;

  UserDB.fromJson(Map<String, dynamic> json)
      : _id = json['id'],
        _uid = json['uid'],
        _name = json['name'],
        _photoUrl = json['photoUrl'],
        _s3 = json['s3'],
        _location = json['location'];

  Map<String, dynamic> toJson() => {
        "uid": _uid,
        "name": _name,
        "photoUrl": _photoUrl,
        "s3": _s3,
        "location": _location,
      };
}
