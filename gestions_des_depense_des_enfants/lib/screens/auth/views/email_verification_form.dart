import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gestions_des_depense_des_enfants/routes/paths.dart';
import 'package:gestions_des_depense_des_enfants/screens/auth/controllers/register.controller.dart';
import 'package:get/get.dart';

class EmailVerificationForm extends StatelessWidget {
  const EmailVerificationForm({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
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
                    const Padding(
                      padding: EdgeInsets.only(
                          top: 0, left: 30, right: 30, bottom: 10),
                      child: Text(
                        "Email Address Verification",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            height: 1.2,
                            fontSize: 30,
                            color: Color.fromARGB(255, 49, 49, 63)),
                      ),
                    ),
                    const Text(
                      "A verification token has been set to",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(
                      Get.find<RegisterController>().email.value,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.blue),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Token *",
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
                                hintText: 'Ex: chYhJyGHG67',
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
                    GetBuilder<RegisterController>(
                      builder: (_) => _.isLoading.value
                          ? Container(
                              padding: const EdgeInsets.all(10.0),
                              width: MediaQuery.of(context).size.width - 40,
                              decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 0, 120, 255),
                                  borderRadius: BorderRadius.circular(10.0)),
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
                                    "Verify",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontFamily: 'Sen',
                                    ),
                                  ),
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
                                Get.find<RegisterController>().reset();
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
    );
  }
}
