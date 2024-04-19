import 'package:flutter/material.dart';
import 'package:gestions_des_depense_des_enfants/Widgets/Buttons/main_menu_button.dart';

class ActionButtonWidget extends StatelessWidget {
  const ActionButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      height: 90,
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width - 60,
          height: 90,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MainMenuButton(
                title: "Cafeteria",
                icon: "assets/icons/main_menu/donut.png",
              ),
              MainMenuButton(
                title: "Achats",
                icon: "assets/icons/main_menu/bag.png",
              ),
              MainMenuButton(
                title: "Wallet",
                icon: "assets/icons/main_menu/wallet.png",
              ),
              MainMenuButton(
                title: "Plus",
                icon: "assets/icons/main_menu/other-apps.png",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
