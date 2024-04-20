import 'package:gestions_des_depense_des_enfants/screens/child/controllers/child.controller.dart';
import 'package:get/get.dart';

class ChildBinds extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChildController());
  }
}
