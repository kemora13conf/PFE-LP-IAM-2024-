import 'package:flutter/material.dart';
import 'package:gestions_des_depense_des_enfants/screens/home/controllers/current_user.controller.dart';
import 'package:get/get.dart';

class ChildBar extends StatelessWidget {
  const ChildBar({super.key});

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
          ElevatedButton(
            onPressed: () {
              Get.back();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.all(0),
            ),
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.5),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    offset: const Offset(0, 0),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Container(
                height: 20,
                width: 20,
                padding: const EdgeInsets.only(
                  left: 10,
                  top: 13,
                  right: 13,
                  bottom: 13,
                ),
                child: const Image(
                  image: AssetImage("assets/icons/back.png"),
                  height: 10,
                ),
              ),
            ),
          ),
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
