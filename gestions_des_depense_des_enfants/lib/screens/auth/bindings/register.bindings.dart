import 'package:gestions_des_depense_des_enfants/screens/auth/controllers/register.controller.dart';
import 'package:get/get.dart';

class RegisterBinds extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterController());
  }
}