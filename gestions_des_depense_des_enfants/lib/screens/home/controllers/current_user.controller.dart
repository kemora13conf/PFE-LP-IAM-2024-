import 'package:gestions_des_depense_des_enfants/models/parent.model.dart';
import 'package:gestions_des_depense_des_enfants/routes/paths.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurrentUserController extends GetxController {
  ParentModel? user;

  void setUser(ParentModel user) {
    this.user = user;
    update();
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Get.offAllNamed(Paths.AUTH);
  }
}