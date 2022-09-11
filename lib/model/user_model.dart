import 'dart:convert';

class UserModel {
  UserModel({
    this.id,
    this.name,
    this.surname,
    this.image,
    this.phone,
    this.email,
    this.city,
    this.job,
    this.about,
  });

  final String? id;
  final String? name;
  final String? surname;
  final String? image;
  final String? phone;
  final String? email;
  final String? city;
  final String? job;
  final String? about;

  factory UserModel.fromRawJson(String str) => UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    name: json["name"],
    surname: json["surname"],
    image: json["image"],
    phone: json["phone"],
    email: json["email"],
    city: json["city"],
    job: json["job"],
    about: json["about"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "surname": surname,
    "image": image,
    "phone": phone,
    "email": email,
    "city": city,
    "job": job,
    "about": about,
  };
}
