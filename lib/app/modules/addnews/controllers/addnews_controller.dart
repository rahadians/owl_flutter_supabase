import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:path_provider/path_provider.dart';
import '../../../assets/models/constant.dart';

class AddnewsController extends GetxController {
  SupabaseClient client = Supabase.instance.client;

  RxString avatarUrl = "".obs;
  RxString imageUrl = "".obs;
  RxString imageUrlStr = "".obs;
  RxString device = "".obs;
  RxString filepath = "".obs;
  RxBool isLoadingadd = false.obs;
  RxString selectedImagePath = ''.obs;
  RxString selectedImageName = ''.obs;
  RxString selectedImageSize = ''.obs;
  RxString no_id = "".obs;
  RxString animationController = "".obs;
  RxString isiBarcode = "".obs;

  // bool isLoadingadd = false;

  late Uint8List filebytes;

  late File xfile;

  File? ambilGambar;
  late File imageFile;

  final titleC = TextEditingController();
  final contentC = TextEditingController();
  final descC = TextEditingController();
  final usernameC = TextEditingController();
  final websiteC = TextEditingController();
  final dateC = TextEditingController();
  final barcodeC = TextEditingController();

  // final SupabaseClient client =
  //     SupabaseClient(BaseUrl.cBaseUrl, BaseUrl.cAnonKey);

  Future<void> upload(ImageSource imageSource) async {
    isLoadingadd.value = true;
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

    File tmpFile = File(imageFile.path);

    final bytes = await imageFile.readAsBytes();
    final fileExt = imageFile.path.split('.').last;
    final fileName = '${DateTime.now().toIso8601String()}.$fileExt';
    final filePath = fileName;
    filepath.value = filePath.toString();
    filebytes = bytes;

    isiBarcode.value = fileName.toString() + filePath.toString();
    print(DateTime.now().toIso8601String().substring(1, 4));
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

    isLoadingadd.value = false;
  }

  void simpan() async {
    if (imageUrl.value == "" ||
        imageUrl.value.isEmpty ||
        titleC.value == "" ||
        titleC.text.isEmpty ||
        contentC.value == "" ||
        contentC.text.isEmpty ||
        descC.value == "" ||
        descC.text.isEmpty ||
        dateC.value == "" ||
        dateC.text.isEmpty) {
      kDialoWarning();
    } else {
      isLoadingadd.value = true;

      simpanGambar(filepath.value, filebytes);

      try {
        print(imageUrlStr.value.runtimeType);
        print("ini imagestr ${imageUrlStr.value}");
        await client.from("tbl_news").insert({
          "id_user": client.auth.currentUser!.id,
          "title": titleC.text,
          "content": contentC.text,
          "created_at": DateTime.now().toIso8601String(),
          "date_news": dateC.text,
          "description": descC.text,
          "imageUrl": imageUrlStr.value,
          "code_item": isiBarcode.value
        }).execute();
        kDialogOk();
        isLoadingadd.value = false;
      } catch (err) {
        print("ada kesalahan ${err} di simpan table");
      }

      isLoadingadd.value = false;
    }
  }

  void simpanGambar(path, bytes) {
    try {
      final response =
          client.storage.from('images/images').uploadBinary(path, bytes);

      StorageResponse<String> imageUrlResponse =
          client.storage.from('images/images').getPublicUrl(path);

      imageUrlStr.value = imageUrlResponse.data.toString();
    } catch (err) {
      print(err);
    }
  }

  void hapusText() {
    imageUrl.value = "";
    titleC.text = "";
    contentC.text = "";
    descC.text = "";
    usernameC.text = "";
    websiteC.text = "";
    dateC.text = "";
  }

  Future<dynamic> kDialoWarning() {
    return Get.defaultDialog(
      title: "Warning",
      middleText: "Data Belum Terisi",
      backgroundColor: Colors.teal,
      titleStyle: TextStyle(color: Colors.white),
      middleTextStyle: TextStyle(color: Colors.white),
      radius: 30,
      actions: [
        TextButton(
          child: const Text("Close"),
          onPressed: () {
            Get.back();
          },
        ),
      ],
    );
  }

  Future<dynamic> kDialogOk() {
    return Get.defaultDialog(
      title: "Success",
      middleText: "Data Sudah Tersimpan",
      backgroundColor: Colors.teal,
      titleStyle: TextStyle(color: Colors.white),
      middleTextStyle: TextStyle(color: Colors.white),
      radius: 30,
      actions: [
        TextButton(
          child: const Text("Close"),
          onPressed: () {
            hapusText();
            Get.back();
          },
        ),
      ],
    );
  }
}
