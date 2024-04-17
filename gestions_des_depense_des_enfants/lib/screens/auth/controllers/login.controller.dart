import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gestions_des_depense_des_enfants/Config.dart';
import 'package:gestions_des_depense_des_enfants/models/http_response.model.dart';
import 'package:gestions_des_depense_des_enfants/routes/paths.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  var email = "".obs;
  var password = "".obs;
  var rememberMe = false.obs;

  var isPasswordVisible = false.obs;

  var emailError = "".obs;
  var passwordError = "".obs;

  var isLoading = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
    update();
  }

  void onEmailChanged(String value) {
    email.value = value;
  }

  void onPasswordChanged(String value) {
    password.value = value;
  }

  void validateEmail(String value) {
    if (value.isEmpty) {
      emailError.value = "Email is required";
    } else if (!GetUtils.isEmail(value)) {
      emailError.value = "Invalid email address";
    } else {
      emailError.value = "";
    }
  }

  void validatePassword(String value) {
    if (value.isEmpty) {
      passwordError.value = "Password is required";
    } else {
      passwordError.value = "";
    }
  }

  void validateAll() {
    validateEmail(email.value);
    validatePassword(password.value);
    update();
  }

  Future<void> onLogin() async {
    isLoading.value = true;
    update();
    validateAll();
    final response = await http.post(
      Uri.parse("${Config.API_URL}/auth/login"),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        'email': email.value,
        'password': password.value,
      }),
    );
    if (response.statusCode == 200) {
      HttpResponseModel res =
          HttpResponseModel.fromJson(json.decode(response.body));
      if (res.type == "EMAIL_ERR") {
        emailError.value = res.message ?? "Email not found";
      } else if (res.type == "PASSWORD_ERR") {
        passwordError.value = res.message ?? "Invalid password";
      } else if (res.type == "SUCCESS") {
        emailError.value = "";
        passwordError.value = "";

        // Save token to shared preferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("accessToken", res.data["accessToken"]);

        // save ParentModel to shared preferences
        await prefs.setString(
            "parent", json.encode(res.data["parent"]).toString());

        // set isLoggedin to true in shared preferences
        await prefs.setBool("isLoggedin", true);

        // Get Snack bar
        Get.snackbar(
          "Success",
          "Login successful",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // Redirect to home page?
        Get.offAllNamed(Paths.HOME);
      } else {
        Get.snackbar(
          "Error",
          res.message ?? "An error occurred",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } else {
      Get.snackbar(
        "Error",
        "An error occurred",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }

    isLoading.value = false;
    update();
  }
}
