import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gestions_des_depense_des_enfants/Config.dart';
import 'package:gestions_des_depense_des_enfants/models/http_response.model.dart';
import 'package:gestions_des_depense_des_enfants/routes/paths.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

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
    String? accessToken = prefs.getString("accessToken");

    if (accessToken != null) {
      final response = await http.post(
        Uri.parse("${Config.API_URL}/auth/verify-token"),
        headers: {"Content-Type": "application/json"},
        body: json.encode({'token': accessToken}),
      );

      if (response.statusCode == 200) {
        HttpResponseModel responseModel =
            HttpResponseModel.fromJson(json.decode(response.body));
        if (responseModel.type == "TOKEN_VALID") {
          await prefs.setBool("isLoggedin", true);
        } else {
          await prefs.setBool("isLoggedin", false);
        }
      } else {
        await prefs.setBool("isLoggedin", false);
      }
    }

    // wait 2 sec
    bool? isLoggedin = prefs.getBool("isLoggedin");
    if (isLoggedin != null) {
      if (isLoggedin) {
        Get.offAllNamed(Paths.HOME);
      } else {
        Get.offAllNamed(Paths.AUTH);
      }
    } else {
      Future.delayed(const Duration(seconds: 2), () {
        Get.offAllNamed(Paths.WELCOME);
      });
    }
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
