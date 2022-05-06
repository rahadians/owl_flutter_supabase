import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:image_picker/image_picker.dart';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import '../../../assets/models/constant.dart';

class AddnewsController extends GetxController {
  RxBool isLoading = false.obs;

  RxString avatarUrl = "".obs;
  RxString imageUrl = "".obs;
  RxString device = "".obs;
  RxString filepath = "".obs;

  RxString selectedImagePath = ''.obs;
  RxString selectedImageName = ''.obs;
  RxString selectedImageSize = ''.obs;
  RxString no_id = "".obs;
  RxString animationController = "".obs;

  late Uint8List filebytes;

  late File xfile;

  File? ambilGambar;
  late File imageFile;

  final titleC = TextEditingController();
  final contentC = TextEditingController();
  final descC = TextEditingController();
  final usernameC = TextEditingController();
  final websiteC = TextEditingController();

  // final SupabaseClient client =
  //     SupabaseClient(BaseUrl.cBaseUrl, BaseUrl.cAnonKey);
  SupabaseClient client = Supabase.instance.client;

  Future<void> upload(ImageSource imageSource) async {
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(
      source: (imageSource == ImageSource.camera)
          ? ImageSource.camera
          : ImageSource.gallery,
      maxWidth: 200,
      maxHeight: 200,
    );
    if (imageFile == null) {
      return;
      print("gagal");
    }

    isLoading.value = true;

    File tmpFile = File(imageFile.path);

    final bytes = await imageFile.readAsBytes();
    final fileExt = imageFile.path.split('.').last;
    final fileName = '${DateTime.now().toIso8601String()}.$fileExt';
    final filePath = fileName;
    filepath.value = filePath.toString();
    filebytes = bytes;

    final Directory extDir = await getApplicationDocumentsDirectory();
    String dirPath = extDir.path;
    final String extfilePath = '$dirPath/$fileName';

    final File newImage = await tmpFile.copy(extfilePath);

    if (imageFile != null) {
      tmpFile = newImage;
      print("berhasil");
    } else {
      print('No image selected.');
    }

    imageUrl.value = newImage.toString();
    print("========");
    print("${bytes}");
    print(extfilePath);

    // print(imageUrl.value);

    // final response =
    //     await client.storage.from('images/temp').uploadBinary(filePath, bytes);

    isLoading.value = false;

    // final error = response.error;
    // if (error != null) {
    //   Get.snackbar("error", error.message);

    //   return;
    // }

    // StorageResponse<String> imageUrlResponse =
    //     client.storage.from('images/temp').getPublicUrl(filePath);

    // imageUrl.value = imageUrlResponse.data.toString();
    // imageUrl.value = imageFile.name;
  }

  simpan() async {
    // if (imageUrl.value.isNotEmpty &&
    //     usernameC.text.isNotEmpty &&
    //     websiteC.text.isNotEmpty) {

    // if (usernameC.text.isNotEmpty) {
    isLoading.value = true;

    try {
      print("simpanyyee");
      // final response = await client.storage
      //     .from('images/images')
      //     .uploadBinary(filepath.value, filebytes!);

      print(filepath.value);

      final res = await client.storage
          .from('images/temp')
          .remove(['2022-05-05T17:52:34.254481.jpg']);

      final resti =
          await client.storage.from('avatars').remove(['avatar1.jpg']);

      // StorageResponse<String> imageUrlResponse =
      //     client.storage.from('images/images').getPublicUrl(filepath.value);

      // await client.from("profiles").insert({
      //   "id": client.auth.currentUser!.id,
      //   "username": usernameC.text,
      //   "website": websiteC.text,
      //   "avatar_url": imageUrl.value.toString(),
      //   "updated_at": DateTime.now().toIso8601String()
      // }).execute();

      // final response = imageFile;

      Get.snackbar("Info", "Data Sudah Tersimpan",
          duration: Duration(seconds: 3));
    } catch (err) {
      print(err);
    }

    isLoading.value = false;
  }

  Future showToast(String message) async {
    await Fluttertoast.cancel();
    Fluttertoast.showToast(msg: message, fontSize: 18);
  }
}
