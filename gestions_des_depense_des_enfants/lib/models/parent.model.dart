import 'package:gestions_des_depense_des_enfants/models/enfant.mode.dart';

class ParentModel {
  String? id;
  String? fullname;
  String? email;
  String? image;
  String? gender;
  String? solde;
  List<EnfantModel>? enfants;

  ParentModel({
    this.id,
    this.fullname,
    this.email,
    this.image,
    this.gender,
    this.solde,
    this.enfants,
  });

  factory ParentModel.fromJson(Map<String, dynamic> json) {
    return ParentModel(
      id: json['_id'],
      fullname: json['fullname'],
      email: json['email'],
      image: json['image'],
      gender: json['genre'],
      solde: json['solde'],
      enfants: json['enfants']
          .map<EnfantModel>((enfant) => EnfantModel.fromJson(enfant))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'fullname': fullname,
      'email': email,
      'image': image,
      'gender': gender,
      'solde': solde,
      'enfants': enfants?.map((enfant) => enfant.toJson()).toList(),
    };
  }
}
