import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gestions_des_depense_des_enfants/models/parent.model.dart';
import 'package:gestions_des_depense_des_enfants/screens/home/controllers/current_user.controller.dart';
import 'package:gestions_des_depense_des_enfants/screens/home/controllers/side_bar.controller.dart';
import 'package:gestions_des_depense_des_enfants/screens/home/views/home_bar.dart';
import 'package:gestions_des_depense_des_enfants/screens/home/views/home_screen.dart';
import 'package:gestions_des_depense_des_enfants/screens/home/views/side_navigation_bar.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoading = true;
  Future<void> _loadUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? parentString = prefs.getString("parent");
    if (parentString != null) {
      ParentModel user = ParentModel.fromJson(json.decode(parentString));
      Get.find<CurrentUserController>().setUser(user);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  @override
  Widget build(BuildContext context) {
    SideBarController sideBarController = Get.find();
    return Scaffold(
        backgroundColor: Colors.white,
        body: isLoading
            ? Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.white,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Stack(children: [
                GetBuilder<SideBarController>(
                  builder: (_) {
                    return AnimatedPositioned(
                      duration: const Duration(milliseconds: 200),
                      left: sideBarController.isCollapsed.value ? 300 : 0,
                      top: 0,
                      bottom: 0,
                      child: ClipRRect(
                        borderRadius: sideBarController.isCollapsed.value
                            ? const BorderRadius.all(Radius.circular(40))
                            : const BorderRadius.all(Radius.circular(0)),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/splash/splash_background.png"),
                                  fit: BoxFit.cover)),
                          child: const SafeArea(
                              child: Column(
                            children: [MyAppBar(), HomeScreen()],
                          )),
                        ),
                      ),
                    );
                  },
                ),
                GetBuilder<SideBarController>(
                  builder: (_) {
                    return AnimatedPositioned(
                      duration: const Duration(milliseconds: 200),
                      left: sideBarController.isCollapsed.value ? 0 : -300,
                      top: 0,
                      bottom: 0,
                      child: const SideNavigation(),
                    );
                  },
                )
              ]));
  }
}
