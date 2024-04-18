import 'package:flutter/material.dart';
import 'package:gestions_des_depense_des_enfants/routes/paths.dart';
import 'package:gestions_des_depense_des_enfants/screens/home/views/app_bar.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatelessWidget {
  const Home({super.key});
  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Get.offAllNamed(Paths.AUTH);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/splash/splash_background.png"),
                fit: BoxFit.cover)),
        child: SafeArea(
            child: Column(
          children: [
            const MyAppBar(title: "Home"),
            ElevatedButton(
              onPressed: logout,
              child: const Text("Logout"),
            ),
          ],
        )),
      ),
    );
  }
}
