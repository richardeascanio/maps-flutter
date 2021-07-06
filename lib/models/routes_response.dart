import 'dart:convert';

class RoutesResponse {
  RoutesResponse({
    this.routes,
    this.waypoints,
    this.code,
    this.uuid,
  });

  List<Route> routes;
  List<Waypoint> waypoints;
  String code;
  String uuid;

  factory RoutesResponse.fromJson(String str) => RoutesResponse.fromMap(json.decode(str));

  factory RoutesResponse.fromMap(Map<String, dynamic> json) => RoutesResponse(
    routes: List<Route>.from(json["routes"].map((x) => Route.fromMap(x))),
    waypoints: List<Waypoint>.from(json["waypoints"].map((x) => Waypoint.fromMap(x))),
    code: json["code"],
    uuid: json["uuid"],
  );

  Map<String, dynamic> toMap() => {
    "routes": List<dynamic>.from(routes.map((x) => x.toMap())),
    "waypoints": List<dynamic>.from(waypoints.map((x) => x.toMap())),
    "code": code,
    "uuid": uuid,
  };
}

class Route {
  Route({
    this.weightName,
    this.weight,
    this.duration,
    this.distance,
    this.legs,
    this.geometry,
  });

  String weightName;
  double weight;
  double duration;
  double distance;
  List<Leg> legs;
  String geometry;

  factory Route.fromJson(String str) => Route.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Route.fromMap(Map<String, dynamic> json) => Route(
    weightName: json["weight_name"],
    weight: json["weight"].toDouble(),
    duration: json["duration"].toDouble(),
    distance: json["distance"].toDouble(),
    legs: List<Leg>.from(json["legs"].map((x) => Leg.fromMap(x))),
    geometry: json["geometry"],
  );

  Map<String, dynamic> toMap() => {
    "weight_name": weightName,
    "weight": weight,
    "duration": duration,
    "distance": distance,
    "legs": List<dynamic>.from(legs.map((x) => x.toMap())),
    "geometry": geometry,
  };
}

class Leg {
  Leg({
    this.admins,
    this.weight,
    this.duration,
    this.steps,
    this.distance,
    this.summary,
  });

  List<Admin> admins;
  double weight;
  double duration;
  List<dynamic> steps;
  double distance;
  String summary;

  factory Leg.fromJson(String str) => Leg.fromMap(json.decode(str));

  factory Leg.fromMap(Map<String, dynamic> json) => Leg(
    admins: List<Admin>.from(json["admins"].map((x) => Admin.fromMap(x))),
    weight: json["weight"].toDouble(),
    duration: json["duration"].toDouble(),
    steps: List<dynamic>.from(json["steps"].map((x) => x)),
    distance: json["distance"].toDouble(),
    summary: json["summary"],
  );

  Map<String, dynamic> toMap() => {
    "admins": List<dynamic>.from(admins.map((x) => x.toMap())),
    "weight": weight,
    "duration": duration,
    "steps": List<dynamic>.from(steps.map((x) => x)),
    "distance": distance,
    "summary": summary,
  };
}

class Admin {
  Admin({
    this.iso31661Alpha3,
    this.iso31661,
  });

  String iso31661Alpha3;
  String iso31661;

  factory Admin.fromJson(String str) => Admin.fromMap(json.decode(str));

  factory Admin.fromMap(Map<String, dynamic> json) => Admin(
    iso31661Alpha3: json["iso_3166_1_alpha3"],
    iso31661: json["iso_3166_1"],
  );

  Map<String, dynamic> toMap() => {
    "iso_3166_1_alpha3": iso31661Alpha3,
    "iso_3166_1": iso31661,
  };
}

class Waypoint {
  Waypoint({
    this.distance,
    this.name,
    this.location,
  });

  double distance;
  String name;
  List<double> location;

  factory Waypoint.fromJson(String str) => Waypoint.fromMap(json.decode(str));

  factory Waypoint.fromMap(Map<String, dynamic> json) => Waypoint(
    distance: json["distance"].toDouble(),
    name: json["name"],
    location: List<double>.from(json["location"].map((x) => x.toDouble())),
  );

  Map<String, dynamic> toMap() => {
    "distance": distance,
    "name": name,
    "location": List<dynamic>.from(location.map((x) => x)),
  };
}
