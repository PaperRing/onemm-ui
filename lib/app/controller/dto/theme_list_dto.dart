class ThemeListDto {
  final String _title;
  final String? _description;

  ThemeListDto(this._title, this._description);

  String get title => _title;

  String? get description => _description;

  ThemeListDto.fromJson(Map<String, dynamic> json)
      : _title = json['title'],
        _description = json['description'];

  Map<String, dynamic> toJson() => {
    "title": _title,
    "description": _description,
  };
}
