import 'package:flutter/material.dart';
import 'package:gestions_des_depense_des_enfants/routes/paths.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _navigateToApp();
  }


  void _navigateToApp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isLoggedin = prefs.getBool("isLoggedin");

    // wait 2 sec
    Future.delayed(const Duration(milliseconds: 10), () {
      if (isLoggedin != null) {
        if (isLoggedin) {
          Get.offAllNamed(Paths.HOME);
        } else {
          Get.offAllNamed(Paths.AUTH);
        }
      } else {
        Get.offAllNamed(Paths.WELCOME);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: <Widget>[
            Image(
              image: AssetImage('assets/splash/splash_background.png'),
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Center(
              child: Image(
                image: AssetImage('assets/splash/logo.png'),
                width: 200,
                height: 200,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
