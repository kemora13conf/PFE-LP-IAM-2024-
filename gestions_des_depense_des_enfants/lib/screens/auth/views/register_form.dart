import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gestions_des_depense_des_enfants/routes/paths.dart';
import 'package:gestions_des_depense_des_enfants/screens/auth/controllers/register.controller.dart';
import 'package:get/get.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const Padding(
                padding:
                    EdgeInsets.only(top: 30, left: 30, right: 30, bottom: 10),
                child: Text(
                  "Hi Parent, Register yourself!",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                    fontFamily: 'Sen',
                    fontSize: 36,
                    color: Colors.white,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                child: Text(
                  "Let's get started by creating an account!",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(top: 40),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 30, left: 30, right: 30, bottom: 100),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Fullname *",
                            style: TextStyle(
                              color: Color(0xFF374151),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      GetBuilder<RegisterController>(
                          builder: (_) => TextField(
                                onChanged: _.onFullnameChanged,
                                decoration: const InputDecoration(
                                  hintText: 'Ex: Nawal El Moutawakil',
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 15,
                                    horizontal: 20,
                                  ),
                                  hintStyle: TextStyle(
                                    color: Color(0xFFA1A1A1),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                ),
                              )),
                      GetBuilder<RegisterController>(
                        builder: (_) => _.fullnameError.value.isNotEmpty
                            ? Container(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    _.fullnameError.value,
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox(height: 10),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Email Address *",
                            style: TextStyle(
                              color: Color(0xFF374151),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      GetBuilder<RegisterController>(
                          builder: (_) => TextField(
                                onChanged: _.onEmailChanged,
                                decoration: const InputDecoration(
                                  hintText: 'Ex: parent@gmail.com',
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 15,
                                    horizontal: 20,
                                  ),
                                  hintStyle: TextStyle(
                                    color: Color(0xFFA1A1A1),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                ),
                              )),
                      GetBuilder<RegisterController>(
                        builder: (_) => _.emailError.value.isNotEmpty
                            ? Container(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    _.emailError.value,
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox(height: 10),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Password *",
                            style: TextStyle(
                              color: Color(0xFF374151),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      GetBuilder<RegisterController>(
                        builder: (_) => TextField(
                          onChanged: _.onPasswordChanged,
                          obscureText: !_.isPasswordVisible.value,
                          decoration: InputDecoration(
                            hintText: '********',
                            suffixIcon: IconButton(
                              onPressed: () {
                                _.togglePasswordVisibility();
                              },
                              icon: Icon(
                                _.isPasswordVisible.value
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              color: Colors.grey,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 20,
                            ),
                            hintStyle: const TextStyle(
                              color: Color(0xFFA1A1A1),
                            ),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ),
                      GetBuilder<RegisterController>(
                        builder: (_) => _.passwordError.value.isNotEmpty
                            ? Container(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    _.passwordError.value,
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox(height: 10),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Confirm Password *",
                            style: TextStyle(
                              color: Color(0xFF374151),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      GetBuilder<RegisterController>(
                        builder: (_) => TextField(
                          onChanged: _.onConfirmPasswordChanged,
                          obscureText: !_.isConfirmPasswordVisible.value,
                          decoration: InputDecoration(
                            hintText: '********',
                            suffixIcon: IconButton(
                              onPressed: () {
                                _.toggleConfirmPasswordVisibility();
                              },
                              icon: Icon(
                                _.isConfirmPasswordVisible.value
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              color: Colors.grey,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 20,
                            ),
                            hintStyle: const TextStyle(
                              color: Color(0xFFA1A1A1),
                            ),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ),
                      GetBuilder<RegisterController>(
                        builder: (_) => _.confirmPasswordError.value.isNotEmpty
                            ? Container(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    _.confirmPasswordError.value,
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox(height: 10),
                      ),
                      GetBuilder<RegisterController>(
                        builder: (_) => _.isLoading.isFalse
                            ? Container(
                                width: double.infinity,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 10, bottom: 0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Get.find<RegisterController>().nextStep();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF6C63FF),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 20),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    child: const Text(
                                      "Verify Email Address",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontFamily: 'Sen',
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Container(
                                padding: const EdgeInsets.all(10.0),
                                width: MediaQuery.of(context).size.width - 40,
                                decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 0, 120, 255),
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 4.0,
                                    strokeAlign: BorderSide.strokeAlignInside,
                                  ),
                                ),
                              ),
                      ),
                      const SizedBox(height: 20),
                      // Already have an account
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: const TextStyle(
                            color: Color(0xFF374151),
                            fontSize: 16.0,
                          ),
                          children: [
                            const TextSpan(
                              text: "Already have an account?",
                            ),
                            TextSpan(
                              text: 'Sign in',
                              style: const TextStyle(
                                color: Color(0xFF6C63FF),
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Get.toNamed(Paths.LOGIN);
                                },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
