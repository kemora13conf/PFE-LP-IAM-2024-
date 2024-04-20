import 'package:gestions_des_depense_des_enfants/models/enfant.model.dart';
import 'package:get/get.dart';

class ChildController extends GetxController {
  EnfantModel? child;

  void setChild(EnfantModel value) {
    child = value;
    update();
  }
}
