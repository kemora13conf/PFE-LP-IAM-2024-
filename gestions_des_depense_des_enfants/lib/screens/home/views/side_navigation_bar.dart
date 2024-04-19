import 'package:flutter/material.dart';
import 'package:gestions_des_depense_des_enfants/Config.dart';
import 'package:gestions_des_depense_des_enfants/routes/paths.dart';
import 'package:gestions_des_depense_des_enfants/screens/home/controllers/current_user.controller.dart';
import 'package:gestions_des_depense_des_enfants/screens/home/controllers/side_bar.controller.dart';
import 'package:get/get.dart';

class SideNavigation extends StatelessWidget {
  const SideNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    CurrentUserController currentUser = Get.find();

    return Container(
      width: 300,
      height: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                        "${Config.ASSETS_URL}/Parents-images/${currentUser.user!.image ?? "parent-default.png"}"),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                width: double.infinity,
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      child: Text(
                        textAlign: TextAlign.left,
                        currentUser.user!.fullname ?? "",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      alignment: Alignment.topLeft,
                      child: Text(
                        textAlign: TextAlign.left,
                        currentUser.user!.email ?? "",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const SizedBox(height: 20),
              ListTile(
                title: const Text(
                  "My Profile",
                  style: TextStyle(
                    color: Color.fromARGB(255, 86, 82, 95),
                    fontSize: 18,
                    fontFamily: "Sen",
                    fontWeight: FontWeight.w900,
                  ),
                ),
                leading: Image.asset("assets/icons/Profile.png",
                    width: 20, height: 20),
                onTap: () {},
              ),
              ListTile(
                title: const Text(
                  "My Childs",
                  style: TextStyle(
                    color: Color.fromARGB(255, 86, 82, 95),
                    fontSize: 18,
                    fontFamily: "Sen",
                    fontWeight: FontWeight.w900,
                  ),
                ),
                leading: Image.asset("assets/icons/Profile.png",
                    width: 20, height: 20),
                onTap: () {},
              ),
              ListTile(
                title: const Text(
                  "Cafeteria",
                  style: TextStyle(
                    color: Color.fromARGB(255, 86, 82, 95),
                    fontSize: 18,
                    fontFamily: "Sen",
                    fontWeight: FontWeight.w900,
                  ),
                ),
                leading: Image.asset("assets/icons/Location.png",
                    width: 20, height: 20),
                onTap: () {},
              ),
              ListTile(
                title: const Text(
                  "Childs orders",
                  style: TextStyle(
                    color: Color.fromARGB(255, 86, 82, 95),
                    fontSize: 18,
                    fontFamily: "Sen",
                    fontWeight: FontWeight.w900,
                  ),
                ),
                leading: Image.asset("assets/icons/Document.png",
                    width: 20, height: 20),
                onTap: () {},
              ),
              ListTile(
                title: const Text(
                  "Payment Methods",
                  style: TextStyle(
                    color: Color.fromARGB(255, 86, 82, 95),
                    fontSize: 18,
                    fontFamily: "Sen",
                    fontWeight: FontWeight.w900,
                  ),
                ),
                leading: Image.asset("assets/icons/Wallet.png",
                    width: 20, height: 20),
                onTap: () {},
              ),
              ListTile(
                title: const Text(
                  "Settings",
                  style: TextStyle(
                    color: Color.fromARGB(255, 86, 82, 95),
                    fontSize: 18,
                    fontFamily: "Sen",
                    fontWeight: FontWeight.w900,
                  ),
                ),
                leading: Image.asset("assets/icons/Setting.png",
                    width: 20, height: 20),
                onTap: () {},
              ),
              ListTile(
                title: const Text(
                  "Contact Us",
                  style: TextStyle(
                    color: Color.fromARGB(255, 86, 82, 95),
                    fontSize: 18,
                    fontFamily: "Sen",
                    fontWeight: FontWeight.w900,
                  ),
                ),
                leading: Image.asset("assets/icons/Message.png",
                    width: 20, height: 20),
                onTap: () {},
              ),
              ListTile(
                title: const Text(
                  "Helps & FAQs",
                  style: TextStyle(
                    color: Color.fromARGB(255, 86, 82, 95),
                    fontSize: 18,
                    fontFamily: "Sen",
                    fontWeight: FontWeight.w900,
                  ),
                ),
                leading: Image.asset("assets/icons/Vector.png",
                    width: 20, height: 20),
                onTap: () {},
              ),
              ListTile(
                title: const Text(
                  "Log Out",
                  style: TextStyle(
                    color: Color.fromARGB(255, 86, 82, 95),
                    fontSize: 18,
                    fontFamily: "Sen",
                    fontWeight: FontWeight.w900,
                  ),
                ),
                onTap: () {
                  Get.find<CurrentUserController>().logout();
                  Get.find<SideBarController>().toggle();
                  Get.offAllNamed(Paths.LOGIN);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
