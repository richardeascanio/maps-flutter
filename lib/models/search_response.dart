// To parse this JSON data, do
//
//     final searchResponse = searchResponseFromMap(jsonString);

import 'dart:convert';

class SearchResponse {
  SearchResponse({
    this.type,
    this.query,
    this.features,
    this.attribution,
  });

  String type;
  List<String> query;
  List<Feature> features;
  String attribution;

  factory SearchResponse.fromJson(String str) => SearchResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SearchResponse.fromMap(Map<String, dynamic> json) => SearchResponse(
    type: json["type"],
    query: List<String>.from(json["query"].map((x) => x)),
    features: List<Feature>.from(json["features"].map((x) => Feature.fromMap(x))),
    attribution: json["attribution"],
  );

  Map<String, dynamic> toMap() => {
    "type": type,
    "query": List<dynamic>.from(query.map((x) => x)),
    "features": List<dynamic>.from(features.map((x) => x.toMap())),
    "attribution": attribution,
  };
}

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
    context: List<Context>.from(json["context"].map((x) => Context.fromMap(x))),
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

class Geometry {
  Geometry({
    this.coordinates,
    this.type,
  });

  List<double> coordinates;
  String type;

  factory Geometry.fromJson(String str) => Geometry.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Geometry.fromMap(Map<String, dynamic> json) => Geometry(
    coordinates: List<double>.from(json["coordinates"].map((x) => x.toDouble())),
    type: json["type"],
  );

  Map<String, dynamic> toMap() => {
    "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
    "type": type,
  };
}

class Properties {
  Properties({
    this.foursquare,
    this.landmark,
    this.wikidata,
    this.address,
    this.category,
  });

  String foursquare;
  bool landmark;
  String wikidata;
  String address;
  String category;

  factory Properties.fromJson(String str) => Properties.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Properties.fromMap(Map<String, dynamic> json) => Properties(
    foursquare: json["foursquare"],
    landmark: json["landmark"],
    wikidata: json["wikidata"] == null ? null : json["wikidata"],
    address: json["address"],
    category: json["category"],
  );

  Map<String, dynamic> toMap() => {
    "foursquare": foursquare,
    "landmark": landmark,
    "wikidata": wikidata == null ? null : wikidata,
    "address": address,
    "category": category,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
