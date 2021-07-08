import 'dart:convert';

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