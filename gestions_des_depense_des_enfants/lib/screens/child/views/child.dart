import 'package:flutter/material.dart';
import 'package:gestions_des_depense_des_enfants/models/enfant.model.dart';
import 'package:gestions_des_depense_des_enfants/screens/child/controllers/child.controller.dart';
import 'package:gestions_des_depense_des_enfants/screens/child/views/child_bar.dart';
import 'package:get/get.dart';

class Child extends StatefulWidget {
  const Child({super.key});

  @override
  State<Child> createState() => _ChildState();
}

class _ChildState extends State<Child> {
  late ChildController childController;
  @override
  void initState() {
    super.initState();
    childController = Get.find();

    childController.setChild(Get.arguments as EnfantModel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/splash/splash_background.png"),
              fit: BoxFit.cover)),
      child: const SafeArea(
          child: Column(
        children: [ChildBar()],
      )),
    ));
  }
}
