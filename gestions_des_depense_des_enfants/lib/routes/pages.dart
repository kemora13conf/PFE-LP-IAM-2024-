import 'package:flutter/material.dart';
import 'package:gestions_des_depense_des_enfants/routes/paths.dart';
import 'package:gestions_des_depense_des_enfants/screens/Welcome/welcome.dart';
import 'package:gestions_des_depense_des_enfants/screens/add_child/bindings/add_child.bindings.dart';
import 'package:gestions_des_depense_des_enfants/screens/add_child/views/add_child_form.dart';
import 'package:gestions_des_depense_des_enfants/screens/auth/bindings/forgot_password.bindings.dart';
import 'package:gestions_des_depense_des_enfants/screens/auth/bindings/login.bindings.dart';
import 'package:gestions_des_depense_des_enfants/screens/auth/bindings/register.bindings.dart';
import 'package:gestions_des_depense_des_enfants/screens/auth/bindings/reset_password.bindings.dart';
import 'package:gestions_des_depense_des_enfants/screens/auth/views/auth.dart';
import 'package:gestions_des_depense_des_enfants/screens/auth/views/forgot_password.dart';
import 'package:gestions_des_depense_des_enfants/screens/auth/views/login.dart';
import 'package:gestions_des_depense_des_enfants/screens/auth/views/register.dart';
import 'package:gestions_des_depense_des_enfants/screens/auth/views/reset_password.dart';
import 'package:gestions_des_depense_des_enfants/screens/child/bindings/child.bindings.dart';
import 'package:gestions_des_depense_des_enfants/screens/child/views/child.dart';
import 'package:gestions_des_depense_des_enfants/screens/home/bindings/home.bindings.dart';
import 'package:gestions_des_depense_des_enfants/screens/home/views/home.dart';
import 'package:gestions_des_depense_des_enfants/screens/splahs.dart';
import 'package:gestions_des_depense_des_enfants/screens/welcome/welcome.bindings.dart';
import 'package:get/get.dart';

class Pages {
  Pages._();

  static final routes = [
    GetPage(
      name: Paths.SPLASH,
      page: () => const Splash(),
    ),
    GetPage(
        name: Paths.WELCOME,
        page: () => const Welcome(),
        binding: WelcomeBinds(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(seconds: 1)),
    GetPage(
        name: Paths.AUTH,
        page: () => const Auth(),
        transition: Transition.fade,
        curve: Curves.easeInCubic,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
      name: Paths.LOGIN,
      page: () => const Login(),
      transition: Transition.fade,
      curve: Curves.easeInCubic,
      transitionDuration: const Duration(milliseconds: 500),
      binding: LoginBinds(),
    ),
    GetPage(
      name: Paths.REGISTER,
      page: () => const Register(),
      transition: Transition.fade,
      curve: Curves.easeInCubic,
      transitionDuration: const Duration(milliseconds: 500),
      binding: RegisterBinds(),
    ),
    GetPage(
      name: Paths.FORGOT_PASSWORD,
      page: () => const ForgotPassword(),
      transition: Transition.fade,
      curve: Curves.easeInCubic,
      binding: ForgotPasswordBinds(),
    ),
    GetPage(
      name: Paths.RESET_PASSWORD,
      page: () => const ResetPassword(),
      transition: Transition.fade,
      curve: Curves.easeInCubic,
      binding: ResetPasswordBinds(),
    ),
    GetPage(
        name: Paths.HOME,
        page: () => const Home(),
        transition: Transition.fade,
        curve: Curves.easeInCubic,
        transitionDuration: const Duration(milliseconds: 500),
        binding: HomeBinds()),
    GetPage(
      name: Paths.ADD_CHILD,
      page: () => const AddChildForm(),
      transition: Transition.fade,
      curve: Curves.easeInCubic,
      transitionDuration: const Duration(milliseconds: 500),
      binding: AddChildBinds(),
    ),
    GetPage(
      name: Paths.CHILD,
      page: () => const Child(),
      transition: Transition.fade,
      curve: Curves.easeInCubic,
      transitionDuration: const Duration(milliseconds: 500),
      binding: ChildBinds(),
    ),
  ];
}
