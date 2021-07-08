import 'dart:convert';

import 'package:maps_app/models/properties_model.dart';

import 'context_model.dart';
import 'geometry_model.dart';

class Feature {
  Feature({
    this.id,
    this.type,
    this.placeType,
    this.relevance,
    this.properties,
    this.textEs,
    this.languageEs,
    this.placeNameEs,
    this.text,
    this.language,
    this.placeName,
    this.center,
    this.geometry,
    this.context,
  });

  String id;
  String type;
  List<String> placeType;
  int relevance;
  Properties properties;
  String textEs;
  String languageEs;
  String placeNameEs;
  String text;
  String language;
  String placeName;
  List<double> center;
  Geometry geometry;
  List<Context> context;

  factory Feature.fromJson(String str) => Feature.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Feature.fromMap(Map<String, dynamic> json) => Feature(
    id: json["id"],
    type: json["type"],
    placeType: List<String>.from(json["place_type"].map((x) => x)),
    relevance: json["relevance"].toInt(),
    properties: Properties.fromMap(json["properties"]),
    textEs: json["text_es"],
    languageEs: json["language_es"] == null
      ? null
      : json["language_es"],
    placeNameEs: json["place_name_es"],
    text: json["text"],
    language: json["language"] == null
      ? null
      : json["language"],
    placeName: json["place_name"],
    center: List<double>.from(json["center"].map((x) => x.toDouble())),
    geometry: Geometry.fromMap(json["geometry"]),
    context: json["context"] == null ? null : List<Context>.from(json["context"].map((x) => Context.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "type": type,
    "place_type": List<dynamic>.from(placeType.map((x) => x)),
    "relevance": relevance,
    "properties": properties.toMap(),
    "text_es": textEs,
    "language_es": languageEs == null ? null : languageEs,
    "place_name_es": placeNameEs,
    "text": text,
    "language": language == null ? null : language,
    "place_name": placeName,
    "center": List<dynamic>.from(center.map((x) => x)),
    "geometry": geometry.toMap(),
    "context": List<dynamic>.from(context.map((x) => x.toMap())),
  };
}