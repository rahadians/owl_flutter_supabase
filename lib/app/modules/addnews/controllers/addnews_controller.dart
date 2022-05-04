import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:file_picker/file_picker.dart';

import '../../../assets/models/constant.dart';

class AddnewsController extends GetxController {
  RxBool isLoading = false.obs;

  RxString avatarUrl = "".obs;
  RxString imageUrl = "".obs;

  RxString selectedImagePath = ''.obs;
  RxString selectedImageName = ''.obs;
  RxString selectedImageSize = ''.obs;

  // late XFile? ambilGambar;
  late File xfile;

  File? ambilGambar;
  late File imageFile;

  final titleC = TextEditingController();
  final contentC = TextEditingController();
  final descC = TextEditingController();
  final usernameC = TextEditingController();
  final websiteC = TextEditingController();

  final SupabaseClient client =
      SupabaseClient(BaseUrl.cBaseUrl, BaseUrl.cAnonKey);

  Future<void> upload() async {
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 200,
      maxHeight: 200,
    );
    if (imageFile == null) {
      return;
    }

    isLoading.value = true;

    final bytes = await imageFile.readAsBytes();
    final fileExt = imageFile.path.split('.').last;
    final fileName = '${DateTime.now().toIso8601String()}.$fileExt';
    final filePath = fileName;
    final response =
        await client.storage.from('images').uploadBinary(filePath, bytes);

    isLoading.value = false;

    final error = response.error;
    if (error != null) {
      Get.snackbar("error", error.message);

      return;
    }
    StorageResponse<String> imageUrlResponse =
        client.storage.from('images').getPublicUrl(filePath);

    imageUrl.value = imageUrlResponse.data.toString();

    // onUpload(imageUrlResponse.data!);
  }

  // Future<void> onUpload(String imageUrl) async {
  //   final response = await client.from('profiles').upsert({
  //     'id': client.auth.currentUser!.id,
  //     'avatar_url': imageUrl,
  //     "updated_at": updatedAt,
  //     "username": username,
  //     "avatar_url": avatarUrl,
  //     "website": website,
  //   }).execute();
  //   final error = response.error;
  //   if (error != null) {
  //     Get.snackbar("error", error.message);
  //   }
  //   {
  //     avatarUrl.value = imageUrl;
  //     print(avatarUrl.value);

  //     Get.snackbar("error", "Update your profile image");
  //   }
  // }
}
