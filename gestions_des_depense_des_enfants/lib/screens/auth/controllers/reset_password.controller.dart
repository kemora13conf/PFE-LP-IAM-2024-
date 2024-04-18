import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:gestions_des_depense_des_enfants/Config.dart';
import 'package:gestions_des_depense_des_enfants/models/http_response.model.dart';
import 'package:gestions_des_depense_des_enfants/routes/paths.dart';
import 'package:get/get.dart';

class ResetPasswordController extends GetxController {
  var token = "".obs;
  var password = "".obs;
  var confirmPassword = "".obs;
  var isLoading = false.obs;

  var tokenError = "".obs;
  var passwordError = "".obs;
  var confirmPasswordError = "".obs;

  void onTokenChanged(String value) {
    token.value = value;
  }

  void onPasswordChanged(String value) {
    password.value = value;
  }

  void onConfirmPasswordChanged(String value) {
    confirmPassword.value = value;
  }

  Future<bool> resetPassword() async {
    if (token.value.isEmpty) {
      tokenError.value = "Token is required";
      return false;
    } else if (password.value.isEmpty) {
      passwordError.value = "Password is required";
      return false;
    } else if (password.value.length < 6) {
      passwordError.value = "Password must be at least 6 characters";
      return false;
    } else if (confirmPassword.value.isEmpty) {
      confirmPasswordError.value = "Confirm password is required";
      return false;
    } else if (confirmPassword.value != password.value) {
      confirmPasswordError.value = "Passwords do not match";
      return false;
    } else {
      tokenError.value = "";
      passwordError.value = "";
      confirmPasswordError.value = "";

      final response = await http.post(
        Uri.parse("${Config.API_URL}/auth/reset-password"),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          'token': token.value,
          'password': password.value,
        }),
      );

      if (response.statusCode == 200) {
        HttpResponseModel responseModel =
            HttpResponseModel.fromJson(json.decode(response.body));
        if (responseModel.type == "PASSWORD_CHANGED") {
          Get.snackbar(
            "Success",
            "Password changed successfully",
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          Get.offNamed(Paths.LOGIN);
          return true;
        } else if (responseModel.type == "TOKEN_INVALID") {
          tokenError.value = "Token is invalid";
          return false;
        } else if (responseModel.type == "TOKEN_EXPIRED") {
          tokenError.value = "Token is expired";
          return false;
        } else {
          Get.snackbar(
            "Error",
            responseModel.message ?? "An error occurred",
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          return false;
        }
      } else {
        return false;
      }
    }
  }

  Future<void> submit() async {
    isLoading.value = true;
    update();
    await resetPassword();
    isLoading.value = false;
    update();
  }
}
