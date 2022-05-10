import 'dart:ffi';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:owl_flutter/app/modules/signup/controllers/signup_controller.dart';

import '../../../assets/models/constant.dart';

import 'package:owl_flutter/app/modules/signup/views/signup_view.dart';
import '../controllers/login_controller.dart';
import './../../signup/views/signup_view.dart';

class LoginView extends GetView<LoginController> {
  final SignupController signupC = Get.put(SignupController());
  @override
  // final emailC = TextEditingController();
  // final passwordC = TextEditingController();
  final box = GetStorage();

  Widget build(BuildContext context) {
// final SignupC = Get.put(dependency)

    if (box.read("dataLogin") != null) {
      print("data login ada");
      final box = GetStorage();
      controller.emailC.text = box.read("dataLogin")["email"];
      controller.passwordC.text = box.read("dataLogin")["password"];
      controller.rememberme.value = box.read("dataLogin")["rememberme"];
    } else {
      print("data login tidak ada");
    }

    return Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: () {}),
        backgroundColor: kLightgreen,
        appBar: AppBar(
          title: Text('Owl Flutter'),
          centerTitle: true,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SafeArea(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: controller.emailC,
                        autocorrect: false,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Masukkan Email Anda";
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) => controller.email.value = value!,
                        onChanged: (value) {
                          controller.email.value = value;
                        },
                        decoration:
                            kTextFieldDecoration.copyWith(hintText: 'Email'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Obx(
                        () => TextFormField(
                          controller: controller.passwordC,
                          autocorrect: false,
                          obscureText: controller.secureText.value,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Masukkan Password Anda";
                            } else {
                              return null;
                            }
                          },
                          // onSaved: (value) => controller.password.value = value!,
                          onChanged: (value) {
                            controller.password.value = value;
                            // print(controller.email.value);
                          },
                          decoration: kTextFieldDecoration.copyWith(
                            hintText: 'password',
                            suffixIcon: IconButton(
                                onPressed: () {
                                  controller.showHideText();
                                },
                                icon: Icon(controller.secureText.value
                                    ? Icons.visibility_off
                                    : Icons.visibility)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Obx(
                        () => CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.leading,
                          title: Text("Remember Me"),
                          value: controller.rememberme.value,
                          onChanged: (value) {
                            controller.rememberme.toggle();
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(double.maxFinite, 50),
                          primary: kDarkerGreen,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(30),
                            ),
                          ),
                        ),
                        onPressed: () => controller.login(),
                        child: Text(
                          "Login ",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: GestureDetector(
            onVerticalDragStart: (detail) {
              showModalBottomSheet(
                isScrollControlled: true,
                enableDrag: true,
                context: context,
                builder: (context) => SignupView(),
              );
            },
            child: Container(
              height: 80.0,
              color: kLightgreen,
              child: Container(
                child: Column(
                  children: [Icon(Icons.arrow_upward), Text("Sign Up")],
                ),
                decoration: BoxDecoration(
                    color: kYellow,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30.0))),
              ),
            ),
          ),
        ));
  }
}
