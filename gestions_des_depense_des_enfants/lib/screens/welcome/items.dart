import 'package:flutter/material.dart';
import 'package:gestions_des_depense_des_enfants/routes/paths.dart';
import 'package:get/get.dart';

class Items {
  Items._();

  static Widget item1() {
    return const Padding(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
        child: Center(
          child: Column(
            children: [
              Image(
                image: AssetImage('assets/welcome/welcome-1.png'),
                fit: BoxFit.contain,
                width: 280.0,
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 15),
                child: Text(
                  "Select the Favorites Menu",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.0),
                child: Text(
                  "Now eat well, don't leave the house, You can choose your favorite food only with one click",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Colors.black45,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ));
  }

  static Widget item2() {
    return const Padding(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
        child: Center(
          child: Column(
            children: [
              Image(
                image: AssetImage('assets/welcome/welcome-2.png'),
                fit: BoxFit.contain,
                width: 280.0,
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 15),
                child: Text(
                  "Select the Favorites Menu",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.0),
                child: Text(
                  "Now eat well, don't leave the house, You can choose your favorite food only with one click",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Colors.black45,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ));
  }

  static Widget item3() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
        child: Center(
          child: Column(
            children: [
              const Image(
                image: AssetImage('assets/welcome/welcome-3.png'),
                fit: BoxFit.contain,
                width: 280.0,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 15),
                child: Text(
                  "Select the Favorites Menu",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.0),
                child: Text(
                  "Now eat well, don't leave the house, You can choose your favorite food only with one click",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Colors.black45,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 70.0),
                child: ElevatedButton(
                    onPressed: () {
                      Get.offNamed(Paths.AUTH);
                    },
                    style: ElevatedButton.styleFrom(
                      // primary: Colors.blue,
                      backgroundColor: Colors.blue,

                      padding: const EdgeInsets.symmetric(horizontal: 50.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "Get Started",
                      style: TextStyle(color: Colors.white),
                    )),
              ),
            ],
          ),
        ));
  }
}
