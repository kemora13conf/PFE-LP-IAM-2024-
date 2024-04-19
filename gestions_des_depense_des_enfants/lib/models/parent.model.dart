import 'package:gestions_des_depense_des_enfants/models/enfant.model.dart';

class ParentModel {
  String? id;
  String? fullname;
  String? email;
  String? image;
  String? gender;
  int? solde;

  ParentModel({
    this.id,
    this.fullname,
    this.email,
    this.image,
    this.gender,
    this.solde,
  });

  factory ParentModel.fromJson(Map<String, dynamic> json) {
    return ParentModel(
      id: json['_id'],
      fullname: json['nom'],
      email: json['email'],
      image: json['image'],
      gender: json['genre'],
      solde: json['solde'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'nom': fullname,
      'email': email,
      'image': image,
      'genre': gender,
      'solde': solde,
    };
  }
}
