import 'dart:convert';

Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));

String profileToJson(Profile data) => json.encode(data.toJson());

class Profile {
  Profile({
    required this.email,
    required this.displayName,
    required this.profilePicture,
  });

  String email;
  String displayName;
  String profilePicture;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        email: json["email"],
        displayName: json["displayName"],
        profilePicture: json["profilePicture"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "displayName": displayName,
        "profilePicture": profilePicture,
      };
}
