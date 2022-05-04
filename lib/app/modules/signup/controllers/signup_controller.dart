import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:supabase_flutter/supabase_flutter.dart';

class SignupController extends GetxController {
  RxString userName = "".obs;
  RxString email = "".obs;
  RxString password = "".obs;
  RxBool rememberme = false.obs;
  RxInt nilai = 0.obs;
  RxBool secureText = true.obs;
  RxString title = "".obs;
  RxBool rest = false.obs;

  RxString content = "".obs;
  RxString description = "".obs;
  RxString idUser = "".obs;

  TextEditingController userNameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();

  SupabaseClient client = Supabase.instance.client;

  void register() async {
    try {
      GotrueSessionResponse res =
          await client.auth.signUp(emailC.text, passwordC.text);

      print(res.data);
      if (res.error == null) {
        await client.from("tbl_user").insert({
          "email": client.auth.currentUser!.email,
          "username": userNameC.text,
          "created_at": DateTime.now().toIso8601String(),
          "user_id": client.auth.currentUser!.id,
        }).execute();

        Get.defaultDialog(
            title: "Attantion",
            middleText: "Silahkan Cek Email Anda",
            textConfirm: "Confirm",
            onConfirm: () {
              userNameC.text = "";
              emailC.text = "";
              passwordC.text = "";
              Get.back();
              Get.back();
            });
      } else {
        print("register gagal");
      }

      // print((Response != null) ? "ada data" : "tidak ada data");
      // var hasil = json.decode(Response.body) as Map<String, dynamic>;

      // print(hasil);
      // int value = hasil["value"];
      // if (value == 1) {
      //   Get.defaultDialog(
      //       title: "Register",
      //       middleText: "Register Berhasil Ditambahkan",
      //       onConfirm: () {
      //         Get.back();
      //         Get.back();
      //       });
      // }
    } catch (err) {
      print(err);
    }
  }

  void showHideText() {
    secureText.value = !secureText.value;
  }

  @override
  void onClose() {
    // TODO: implement onClose
    emailC.dispose();
    userNameC.dispose();
    passwordC.dispose();
    super.onClose();
  }
}
