import 'package:gestions_des_depense_des_enfants/screens/home/controllers/current_user.controller.dart';
import 'package:gestions_des_depense_des_enfants/screens/home/controllers/side_bar.controller.dart';
import 'package:get/get.dart';

class HomeBinds extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CurrentUserController());
    Get.lazyPut(() => SideBarController());
  }
}
