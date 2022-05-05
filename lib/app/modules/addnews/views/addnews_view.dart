import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../assets/models/constant.dart';
import '../controllers/addnews_controller.dart';

// "https://mnxjbshqqxhbadvuazxt.supabase.co/storage/v1/object/public/images/Mango Mojito.jpg",
SupabaseClient client = Supabase.instance.client;

class AddnewsView extends GetView<AddnewsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        print(client.auth.currentUser!.id.runtimeType);
      }),
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            InkWell(
                onTap: () => controller.upload(),
                child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Obx(() => (controller.imageUrl.value == "" ||
                            controller.imageUrl.value == "")
                        ? Container(
                            width: double.infinity,
                            height: 200,
                            child: Text("oOk"))
                        : Container(
                            width: double.infinity,
                            height: 200,
                            child: Image.network(
                              controller.imageUrl.value,
                              width: 150,
                              height: 150,
                              fit: BoxFit.cover,
                            ))))),
            TextFormField(
              controller: controller.usernameC,
              keyboardType: TextInputType.text,
              autocorrect: false,
              decoration: kTextFieldDecoration.copyWith(labelText: "Username"),
              onChanged: (value) => value = controller.usernameC.text,
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.multiline,
              maxLength: null, //menyesuaikan isi kontent
              controller: controller.websiteC,
              decoration: kTextFieldDecoration.copyWith(labelText: "Website"),
              onChanged: (value) => value = controller.websiteC.text,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Masukkan Email Anda";
                } else {
                  return null;
                }
              },
            ),
            SizedBox(
              height: 20,
            ),
            // TextFormField(
            //   controller: controller.descC,
            //   autocorrect: false,
            //   keyboardType: TextInputType.emailAddress,
            //   validator: (value) {
            //     if (value!.isEmpty) {
            //       return "Masukkan Email Anda";
            //     } else {
            //       return null;
            //     }
            //   },
            //   // onSaved: (value) => controller.descC.value = value!,
            //   onChanged: (value) {
            //     // controller.descC.value = value;
            //   },
            //   decoration: kTextFieldDecoration.copyWith(hintText: 'Email'),
            // ),
            ElevatedButton(
                onPressed: () {
                  controller.simpan();
                },
                child: Text("Save"))
          ]),
        ),
      ),
    );
  }
}
