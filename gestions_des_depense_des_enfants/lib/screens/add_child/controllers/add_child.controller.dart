import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddChildController extends GetxController {
  var image = "".obs;

  var imageError = "".obs;

  void setImageError(String value) {
    imageError.value = value;
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

}
