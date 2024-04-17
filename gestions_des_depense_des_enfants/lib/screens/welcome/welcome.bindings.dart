import 'package:gestions_des_depense_des_enfants/screens/welcome/welcome.controller.dart';
import 'package:get/get.dart';

class WelcomeBinds extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WelcomeController());
  }
}
