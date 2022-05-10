import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:owl_flutter/app/assets/models/constant.dart';

class ImagepickerController extends GetxController {
  var selectedImagePath = ''.obs;
  var selectedImageName = ''.obs;
  var selectedImageSize = ''.obs;

  XFile? ambilGambar = null;

  Future<void> getImage(ImageSource imageSource) async {
    final dataImage = await ImagePicker().pickImage(source: imageSource);
    if (PickedFile != null) {
      selectedImagePath.value = dataImage!.path;
      selectedImageSize.value =
          ((File(selectedImagePath.value)).lengthSync() / 1024 / 1024)
                  .toStringAsFixed(2) +
              ' Mb';
      ambilGambar = dataImage;
    } else {
      Get.snackbar('Error', 'Tidak ada image dipilih',
          snackPosition: SnackPosition.BOTTOM, backgroundColor: kDarkerGreen);
      ambilGambar = null;
    }
    print(dataImage);
  }
}
