import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddChildController extends GetxController {
  var name = "".obs;
  var cne = "".obs;
  var image = "".obs;
  var gender = "Male".obs;
  var ecole = "Ibn Tofail".obs;
  var niveau = "3eme annee".obs;

  var isLoading = false.obs;

  var nameError = "".obs;
  var cneError = "".obs;
  var imageError = "".obs;
  var ecoleError = "".obs;
  var niveauError = "".obs;

  void onNameChanged(String value) {
    name.value = value;
  }

  void onCneChanged(String value) {
    cne.value = value;
  }

  void onEcoleChanged(String value) {
    ecole.value = value;
  }

  void onNiveauChanged(String value) {
    niveau.value = value;
  }

  void onGenderChanged(String value) {
    gender.value = value;
  }

  Future<void> pickImage() async {
    // Pick image from gallery
    late ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image.value = pickedFile.path;
      update();
    }
  }

  void submit() {
    isLoading.value = true;
    update();
    Future.delayed(Duration(seconds: 3), () {
      isLoading.value = false;
      update();
      Get.back();
    });
  }
}
