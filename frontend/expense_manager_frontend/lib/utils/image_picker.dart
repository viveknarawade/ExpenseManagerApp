import 'dart:io';
import 'package:image_picker/image_picker.dart' as img_picker;

class MyImagePicker {
  File? image;

  // Pick image from gallery
  Future<File?> pickImageFromGallery() async {
    final picker = img_picker.ImagePicker(); // ✅ using package class
    final pickedFile = await picker.pickImage(source: img_picker.ImageSource.gallery);

    if (pickedFile != null) {
      image = File(pickedFile.path);
    }

    return image;
  }
}
