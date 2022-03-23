import 'dart:convert';

Location locationFromJson(String str) => Location.fromJson(json.decode(str));

String locationToJson(Location data) => json.encode(data.toJson());

class Location {
  Location({
    required this.name,
    required this.image,
    required this.items,
  });

  String name;
  String image;
  List<Item> items;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    name: json["name"],
    image: json["image"],
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "image": image,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

class Item {
  Item({
    required this.name,
    required this.subitems,
  });

  String name;
  List<String> subitems;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    name: json["name"],
    subitems: List<String>.from(json["subitems"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "subitems": List<dynamic>.from(subitems.map((x) => x)),
  };
}
