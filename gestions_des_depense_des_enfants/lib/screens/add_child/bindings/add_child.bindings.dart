import 'package:gestions_des_depense_des_enfants/screens/add_child/controllers/add_child.controller.dart';
import 'package:get/get.dart';

class AddChildBinds extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddChildController());
  }
}