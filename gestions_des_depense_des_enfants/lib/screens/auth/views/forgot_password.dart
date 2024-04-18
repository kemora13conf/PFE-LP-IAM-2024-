import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gestions_des_depense_des_enfants/routes/paths.dart';
import 'package:gestions_des_depense_des_enfants/screens/auth/controllers/forgot_password.controller.dart';
import 'package:get/get.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/splash/splash_background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(
                      top: 100, left: 50, right: 50, bottom: 20),
                  child: Text(
                    "Forget Password!",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      height: 1.2,
                      fontFamily: 'Sen',
                      fontSize: 38,
                      color: Colors.white,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 60),
                  child: Text(
                    "Enter your email address to reset your password. You will receive an email with instructions on how to reset your password.",
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
                  height: MediaQuery.of(context).size.height * 0.6,
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
                              "Email Address",
                              style: TextStyle(
                                color: Color(0xFF374151),
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        GetBuilder<ForgotPasswordController>(
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
                        GetBuilder<ForgotPasswordController>(
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
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: RichText(
                              textAlign: TextAlign.start,
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
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        GetBuilder<ForgotPasswordController>(builder: (_) {
                          return _.isLoading.isTrue
                              ? Container(
                                  padding: const EdgeInsets.all(10.0),
                                  width: MediaQuery.of(context).size.width - 40,
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 0, 120, 255),
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  child: const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 4.0,
                                      strokeAlign: BorderSide.strokeAlignInside,
                                    ),
                                  ),
                                )
                              : Container(
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 0),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        _.submit();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFF6C63FF),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 15, horizontal: 20),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      ),
                                      child: const Text(
                                        "Send Verification Email",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontFamily: 'Sen',
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                        }),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
