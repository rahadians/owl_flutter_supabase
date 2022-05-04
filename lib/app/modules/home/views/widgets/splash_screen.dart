// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:owl_flutter/app/modules/home/controllers/home_controller.dart';

import '../../../../assets/models/constant.dart';

class SplashScreen extends GetView<HomeController> {
  @override
  final userNameC = TextEditingController();
  final emailC = TextEditingController();
  final passwordC = TextEditingController();
  final box = GetStorage();

  Widget build(BuildContext context) {
    if (box.read("dataLogin") != null) {
      print("data login ada");

      // final box = GetStorage();

      // emailC.text = box.read("dataLogin")["email"];
      // passwordC.text = box.read("dataLogin")["password"];
      // controller.email.value = box.read("dataLogin")["email"];
      // controller.password.value = box.read("dataLogin")["password"];
      // controller.rememberme.value = true;
    } else {
      print("data login tidak ada");
    }

    return Scaffold(
      backgroundColor: kLightgreen,
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
