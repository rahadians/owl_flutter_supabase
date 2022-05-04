import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import 'package:image_picker/image_picker.dart';
import 'package:owl_flutter/app/assets/models/constant.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginController extends GetxController {
  //TODO: Implement HomeController

  RxString userName = "".obs;
  RxString email = "".obs;
  RxString password = "".obs;
  RxBool rememberme = false.obs;
  RxInt nilai = 0.obs;
  RxBool secureText = true.obs;
  RxString title = "".obs;
  RxString userId = "".obs;
  RxBool isLoading = false.obs;
  RxString content = "".obs;
  RxString description = "".obs;
  RxString idUser = "".obs;
  late File imageFile;

  late TextEditingController emailC;
  late TextEditingController passwordC;
  final titleC = TextEditingController();
  final contentC = TextEditingController();
  final descC = TextEditingController();
  final picker = ImagePicker();

  final box = GetStorage();

  SupabaseClient client = Supabase.instance.client;
  void login() async {
    if (emailC.text.isNotEmpty && passwordC.text.isNotEmpty) {
      isLoading.value = true;
      GotrueSessionResponse res = await client.auth
          .signIn(email: emailC.text, password: passwordC.text);
      if (res.error == null) {
        if (rememberme.isTrue) {
          //kalau dichecklist simpan data ke get storage
          final box = GetStorage();
          box.erase();
          box.write("dataLogin", {
            "email": client.auth.currentUser!.email,
            "password": passwordC.text,
            "rememberme": rememberme.value,
          });
        }
        Get.offAllNamed("/home");
      } else {
        Get.snackbar("Error", "Username/Password Salah",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: kDarkerGreen,
            colorText: Colors.black);
      }

      isLoading.value = false;
    } else {
      print("data salah");
    }
  }

  void showHideText() {
    secureText.value = !secureText.value;
  }

  @override
  void onInit() {
    emailC = TextEditingController();
    passwordC = TextEditingController();
  }

  @override
  void onClose() {
    emailC.dispose();
    passwordC.dispose();
  }
}
