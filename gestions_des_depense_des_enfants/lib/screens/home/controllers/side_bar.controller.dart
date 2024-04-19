import 'package:get/get.dart';

class SideBarController extends GetxController {
  var isCollapsed = false.obs;
  
  void toggle() {
    isCollapsed.value = !isCollapsed.value;
    update();
  }
}
