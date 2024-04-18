import 'package:gestions_des_depense_des_enfants/screens/auth/controllers/reset_password.controller.dart';
import 'package:get/get.dart';

class ResetPasswordBinds extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ResetPasswordController());
  }
}