// To parse this JSON data, do
//
//     final reverseQueryResponse = reverseQueryResponseFromMap(jsonString);

import 'dart:convert';

import 'feature_model.dart';

class ReverseQueryResponse {
  ReverseQueryResponse({
    this.type,
    this.query,
    this.features,
    this.attribution,
  });

  String type;
  List<double> query;
  List<Feature> features;
  String attribution;

  factory ReverseQueryResponse.fromJson(String str) =>
      ReverseQueryResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ReverseQueryResponse.fromMap(Map<String, dynamic> json) =>
    ReverseQueryResponse(
      type: json["type"],
      query: List<double>.from(json["query"].map((x) => x.toDouble())),
      features:
          List<Feature>.from(json["features"].map((x) => Feature.fromMap(x))),
      attribution: json["attribution"],
    );

  Map<String, dynamic> toMap() => {
    "type": type,
    "query": List<dynamic>.from(query.map((x) => x)),
    "features": List<dynamic>.from(features.map((x) => x.toMap())),
    "attribution": attribution,
  };
}

class Properties {
  Properties({
    this.accuracy,
    this.wikidata,
    this.shortCode,
  });

  String accuracy;
  String wikidata;
  String shortCode;

  factory Properties.fromJson(String str) =>
      Properties.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Properties.fromMap(Map<String, dynamic> json) => Properties(
    accuracy: json["accuracy"] == null ? null : json["accuracy"],
    wikidata: json["wikidata"] == null ? null : json["wikidata"],
    shortCode: json["short_code"] == null
        ? null
        : json["short_code"],
  );

  Map<String, dynamic> toMap() => {
    "accuracy": accuracy == null ? null : accuracy,
    "wikidata": wikidata == null ? null : wikidata,
    "short_code":
        shortCode == null ? null : shortCode,
  };
}
