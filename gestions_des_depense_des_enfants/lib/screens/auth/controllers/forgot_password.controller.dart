import 'dart:convert';
import 'package:gestions_des_depense_des_enfants/routes/paths.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:gestions_des_depense_des_enfants/Config.dart';
import 'package:gestions_des_depense_des_enfants/models/http_response.model.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  var email = "".obs;
  var isLoading = false.obs;

  var emailError = "".obs;

  void onEmailChanged(String value) {
    email.value = value;
  }

  Future<bool> requestVerificationEmail(String value) async {
    if (value.isEmpty) {
      emailError.value = "Email is required";
      return false;
    } else if (!GetUtils.isEmail(value)) {
      emailError.value = "Invalid email address";
      return false;
    } else {
      final response = await http.post(
        Uri.parse("${Config.API_URL}/auth/send-verification-email"),
        headers: {"Content-Type": "application/json"},
        body: json.encode({'email': email.value, 'update_password': true}),
      );

      if (response.statusCode == 200) {
        HttpResponseModel responseModel =
            HttpResponseModel.fromJson(json.decode(response.body));
        if (responseModel.type == "EMAIL_SENT") {
          emailError.value = "";
          Get.snackbar(
            "Email Sent",
            "An email has been sent to ${email.value} with instructions to reset your password",
            backgroundColor: Colors.green,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
          );
          Get.offNamed(Paths.RESET_PASSWORD);
          return true;
        } else if (responseModel.type == "EMAIL_NOT_EXISTS") {
          emailError.value = responseModel.message ?? "Email does not exist";
          return false;
        } else {
          emailError.value = "";
          Get.snackbar(
            "Error",
            responseModel.message ?? "Failed to send email",
            backgroundColor: Colors.red,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
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
    await requestVerificationEmail(email.value);
    isLoading.value = false;
    update();
  }
}
