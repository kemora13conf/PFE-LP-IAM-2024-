import 'package:flutter/material.dart';
import 'package:gestions_des_depense_des_enfants/Widgets/Buttons/ajouter_solde.dart';
import 'package:gestions_des_depense_des_enfants/screens/home/controllers/current_user.controller.dart';
import 'package:get/get.dart';

class SoldeWidget extends StatelessWidget {
  const SoldeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    CurrentUserController currentUser = Get.find();
    return Column(
      children: [
        const Text(
          "Solde Actuel",
          style: TextStyle(
            color: Colors.white70,
            fontSize: 14,
            fontWeight: FontWeight.normal,
            fontFamily: "Sen",
          ),
        ),
        Text(
          "${currentUser.user!.solde ?? 0} DH",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
            fontFamily: "Sen",
          ),
        ),
        AddSolde(callBack: () {})
      ],
    );
  }
}
