import 'package:flutter/material.dart';
import 'package:gestions_des_depense_des_enfants/screens/home/views/action_buttons.widget.dart';
import 'package:gestions_des_depense_des_enfants/screens/home/views/body.widget.dart';
import 'package:gestions_des_depense_des_enfants/screens/home/views/solde.widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      // Solde de l'utilisateur
      const SoldeWidget(),
      const SizedBox(height: 20),
      Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height - 280,
        child: const Stack(
          alignment: Alignment.topCenter,
          children: [
            BodyWidget(),
            ActionButtonWidget(),
          ],
        ),
      )
    ]);
  }
}
