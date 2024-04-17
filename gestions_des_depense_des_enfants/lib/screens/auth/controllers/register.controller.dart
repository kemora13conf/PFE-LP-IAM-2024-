import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gestions_des_depense_des_enfants/Config.dart';
import 'package:gestions_des_depense_des_enfants/models/http_response.model.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

var logger = Logger();

class RegisterController extends GetxController {
  var step = 1.obs;

  var fullname = "".obs;
  var email = "".obs;
  var password = "".obs;
  var confirmPassword = "".obs;
  var image = "".obs;
  var gender = "Male".obs;
  var isLoading = false.obs;

  var isPasswordVisible = false.obs;
  var isConfirmPasswordVisible = false.obs;

  var fullnameError = "".obs;
  var emailError = "".obs;
  var passwordError = "".obs;
  var confirmPasswordError = "".obs;
  var imageError = "".obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
    update();
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
    update();
  }

  void onFullnameChanged(String value) {
    fullname.value = value;
  }

  void onEmailChanged(String value) {
    email.value = value;
  }

  void onPasswordChanged(String value) {
    password.value = value;
  }

  void onConfirmPasswordChanged(String value) {
    confirmPassword.value = value;
  }

  void onImageChanged(String value) {
    image.value = value;
  }

  void onGenderChanged(String value) {
    gender.value = value;
  }

  bool validateFullname(String value) {
    if (value.isEmpty) {
      fullnameError.value = "Fullname is required";
      return false;
    } else {
      fullnameError.value = "";
      return true;
    }
  }

  Future<bool> validateEmail(String value) async {
    if (value.isEmpty) {
      emailError.value = "Email is required";
      return false;
    } else if (!GetUtils.isEmail(value)) {
      emailError.value = "Invalid email address";
      return false;
    } else {
      final response = await http.post(
        Uri.parse("${Config.API_URL}/auth/check-email"),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          'email': email.value,
        }),
      );

      if (response.statusCode == 200) {
        HttpResponseModel responseModel =
            HttpResponseModel.fromJson(json.decode(response.body));
        if (responseModel.type == "EMAIL_NOT_EXISTS") {
          emailError.value = "";
          return true;
        } else {
          emailError.value = responseModel.message ?? "Email already exists";
          return false;
        }
      } else {
        return false;
      }
    }
  }

  bool validatePassword(String value) {
    if (value.isEmpty) {
      passwordError.value = "Password is required";
      return false;
    } else if (value.length < 6) {
      passwordError.value = "Password must be at least 6 characters";
      return false;
    } else {
      passwordError.value = "";
      return true;
    }
  }

  bool validateConfirmPassword(String value) {
    if (value.isEmpty) {
      confirmPasswordError.value = "Confirm password is required";
      return false;
    } else if (value != password.value) {
      confirmPasswordError.value = "Password does not match";
      return false;
    } else {
      confirmPasswordError.value = "";
      return true;
    }
  }

  Future<bool> validateFirstStep() async {
    bool isEmailValid = await validateEmail(email.value);
    bool isValid = validateFullname(fullname.value) &
        isEmailValid &
        validatePassword(password.value) &
        validateConfirmPassword(confirmPassword.value);
    isLoading.value = false;
    return isValid;
  }

  bool validateSecondStep() {
    return true;
  }

  bool validateImage(String value) {
    logger.i("Validating image");
    if (value.isEmpty) {
      imageError.value = "Image is required";
      update();
      return false;
    } else {
      imageError.value = "";
      update();
      return true;
    }
  }

  Future<void> pickImage() async {
    // Pick image from gallery
    late ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image.value = pickedFile.path;
      update();
    }
  }

  Future<void> nextStep() async {
    isLoading.value = true;
    update();
    if (step.value == 1) {
      if (await validateFirstStep()) {
        step.value = 2;
      }
    } else if (step.value == 2) {
      step.value = 3;
    } else if (step.value == 3) {
      if (validateImage(image.value)) {
        submit();
      }
    }
    isLoading.value = false;
    update();
  }

  Future<void> submit() async {
    logger.i("Submitting registration form");
    var request = http.MultipartRequest(
        "POST", Uri.parse("${Config.API_URL}/auth/register"));
    request.files.add(await http.MultipartFile.fromPath("image", image.value));
    request.fields["fullname"] = fullname.value;
    request.fields["email"] = email.value;
    request.fields["password"] = password.value;
    request.fields["image"] = image.value;
    request.fields["gender"] = gender.value;

    http.Response reponse =
        await http.Response.fromStream(await request.send());
    logger.i(reponse.statusCode);
    if (reponse.statusCode == 200) {
      HttpResponseModel responseModel =
          HttpResponseModel.fromJson(json.decode(reponse.body));
      if (responseModel.type == "SUCCESS") {
        logger.i(responseModel.message);
        Get.snackbar(
          "Success",
          responseModel.message ?? "Registration successful",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        step.value = 4;
        update();
      } else {
        Get.snackbar(
          "Error",
          responseModel.message ?? "An error occurred",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        step.value = 5;
        update();
      }
    } else {
      logger.e(reponse.body);
    }
  }

  void reset() {
    step.value = 1;
    fullname.value = "";
    email.value = "";
    password.value = "";
    confirmPassword.value = "";
    image.value = "";
    gender.value = "Male";

    isPasswordVisible.value = false;
    isConfirmPasswordVisible.value = false;

    isLoading.value = false;

    fullnameError.value = "";
    emailError.value = "";
    passwordError.value = "";
    confirmPasswordError.value = "";
    imageError.value = "";
  }
}
