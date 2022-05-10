import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../assets/models/constant.dart';

class AvatarController extends GetxController {
  RxBool isLoading = false.obs;
  RxString imageUrl = "".obs;
  RxInt userId = 0.obs;
  RxString avatarUrl = "".obs;

  // RxString pickFile = "".obs;

  final SupabaseClient client =
      SupabaseClient(BaseUrl.cBaseUrl, BaseUrl.cAnonKey);

  Future<void> upload() async {
    isLoading.value = true;
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 300,
      maxHeight: 300,
    );
    if (imageFile == null) {
      return;
    }

    var pickFile = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (pickFile != null) {
      final file = File(pickFile.files.first.path.toString());

      await client.storage
          .from("images")
          .upload(pickFile.files.first.name.toString(), file)
          .then((value) => print(value.data));
      isLoading.value = false;
    }

    Future<void> onUpload(String imageUrl) async {
      final response = await client.from('profiles').upsert({
        'id': userId,
        'avatar_url': imageUrl,
      }).execute();
      final error = response.error;
      if (error != null) {
        Get.snackbar("Error", error.message);
      }
      avatarUrl.value = imageUrl;
      Get.snackbar("Info", "Upload your image");
    }
  }
}


    // final bytes = await imageFile.readAsBytes();
    // final fileExt = imageFile.path.split('.').last;
    // final fileName = '${DateTime.now().toIso8601String()}.$fileExt';
    // final filePath = fileName;
    // final response =
    //     await client.storage.from('images').uploadBinary(filePath, bytes);

// ==========================OPSI===============