import 'dart:convert';

class Context {
  Context({
    this.id,
    this.wikidata,
    this.textEs,
    this.languageEs,
    this.text,
    this.language,
    this.shortCode,
  });

  String id;
  String wikidata;
  String textEs;
  String languageEs;
  String text;
  String language;
  String shortCode;

  factory Context.fromJson(String str) => Context.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Context.fromMap(Map<String, dynamic> json) => Context(
    id: json["id"],
    wikidata: json["wikidata"],
    textEs: json["text_es"],
    languageEs: json["language_es"],
    text: json["text"],
    language: json["language"],
    shortCode: json["short_code"] == null
      ? null
      : json["short_code"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "wikidata": wikidata,
    "text_es": textEs,
    "language_es": languageEs,
    "text": text,
    "language": language,
    "short_code": shortCode == null ? null : shortCode,
  };
}