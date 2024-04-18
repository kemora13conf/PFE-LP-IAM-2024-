import 'package:gestions_des_depense_des_enfants/screens/auth/controllers/forgot_password.controller.dart';
import 'package:get/get.dart';

class ForgotPasswordBinds extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ForgotPasswordController());
  }
}