import 'package:flutter/material.dart';
import 'package:gestions_des_depense_des_enfants/routes/paths.dart';
import 'package:gestions_des_depense_des_enfants/screens/auth/views/agreement_text.dart';
import 'package:get/get.dart';

class Auth extends StatelessWidget {
  const Auth({super.key});

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
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(
                        top: 100, left: 20, right: 20, bottom: 20),
                    child: Image(
                      image: AssetImage('assets/auth/auth.png'),
                      width: 450,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 60),
                    child: Text(
                      "Lest’s Get Started",
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        height: 1.2,
                        fontFamily: 'Sen',
                        fontSize: 44,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 60),
                    child: Text(
                      "Login to your account below or signup for an amazing experience",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  // Sign up button
                  Container(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 60),
                      child: ElevatedButton(
                        onPressed: () {
                          Get.toNamed(Paths.REGISTER);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          "Create Account",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 18,
                            fontFamily: 'Sen',
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Login button
                  Container(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 60),
                      child: ElevatedButton(
                        onPressed: () {
                          Get.toNamed(Paths.LOGIN);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[900],
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            // side: const BorderSide(color: Colors.white, width: 2),
                          ),
                        ),
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: 'Sen',
                          ),
                        ),
                      ),
                    ),
                  ),

                  // term of use with links
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
                    child: AgreementText(),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
