import 'package:flutter/material.dart';
import 'package:gestions_des_depense_des_enfants/screens/auth/controllers/register.controller.dart';
import 'package:gestions_des_depense_des_enfants/screens/auth/views/email_verification_form.dart';
import 'package:gestions_des_depense_des_enfants/screens/auth/views/fail.dart';
import 'package:gestions_des_depense_des_enfants/screens/auth/views/photo_form.dart';
import 'package:gestions_des_depense_des_enfants/screens/auth/views/register_form.dart';
import 'package:gestions_des_depense_des_enfants/screens/auth/views/success.dart';
import 'package:get/get.dart';

class Register extends StatelessWidget {
  const Register({super.key});

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
        child: GetBuilder<RegisterController>(builder: (_) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            key: ValueKey<int>(_.step.value),
            child: currentStep(),
          );
        }),
      ),
    );
  }

  Widget currentStep() {
    switch (Get.find<RegisterController>().step.value) {
      case 1:
        return const RegisterForm();
      case 2:
        return const EmailVerificationForm();
      case 3:
        return const PhotoForm();
      case 4:
        return const Success();
      case 5:
        return const Fail();
      default:
        return const RegisterForm();
    }
  }
}
