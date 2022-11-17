class DemoModel {
  DemoModel({
    this.lang,
  });
  int lang;

  DemoModel copyWith({int lang, double lat}) => DemoModel(
    lang: lang ?? this.lang,
  );

  factory DemoModel.fromJson(Map<String, dynamic> json) => DemoModel(
    lang: json["lang"] ?? 00,
  );

  Map<String, dynamic> toJson() => {
    "lang": lang == null ? null : lang,
  };
}
