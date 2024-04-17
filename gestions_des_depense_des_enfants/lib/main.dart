import 'package:flutter/material.dart';
import 'package:gestions_des_depense_des_enfants/screens/splahs.dart';
import 'package:gestions_des_depense_des_enfants/routes/pages.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Gestion Des Depenses au cafeteria",
      debugShowCheckedModeBanner: false,
      getPages: Pages.routes,
      home: const Splash(),
    );
  }
}
