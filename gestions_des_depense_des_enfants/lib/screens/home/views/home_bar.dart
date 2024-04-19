import 'package:flutter/material.dart';
import 'package:gestions_des_depense_des_enfants/Widgets/Buttons/menu_button.dart';
import 'package:gestions_des_depense_des_enfants/screens/home/controllers/current_user.controller.dart';
import 'package:get/get.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    CurrentUserController currentUser = Get.find();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const MenuButton(),
          Center(
            child: Column(
              children: [
                const SizedBox(height: 5),
                const Text(
                  "Welcome, Back!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: "Sen",
                  ),
                ),
                Text(
                  currentUser.user!.fullname ?? "Hi",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Sen"),
                ),
              ],
            ),
          ),
          const SizedBox(width: 40),
        ],
      ),
    );
  }
}
