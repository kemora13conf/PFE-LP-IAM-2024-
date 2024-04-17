import 'package:gestions_des_depense_des_enfants/screens/auth/controllers/login.controller.dart';
import 'package:get/get.dart';

class LoginBinds extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
  }
}