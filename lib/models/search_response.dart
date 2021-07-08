// To parse this JSON data, do
//
//     final searchResponse = searchResponseFromMap(jsonString);

import 'dart:convert';

import 'feature_model.dart';

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
