import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../assets/models/constant.dart';
import '../controllers/addnews_controller.dart';

// "https://mnxjbshqqxhbadvuazxt.supabase.co/storage/v1/object/public/images/Mango Mojito.jpg",

class AddnewsView extends GetView<AddnewsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {}),
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
              decoration: kTextFieldDecoration.copyWith(labelText: "Title"),
              onChanged: (value) => controller.usernameC.text = value,
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              keyboardType: TextInputType.multiline,
              maxLength: null, //menyesuaikan isi kontent
              controller: controller.websiteC,
              decoration: kTextFieldDecoration.copyWith(labelText: "Content"),
              onChanged: (value) => controller.websiteC.text = value,
            ),
            SizedBox(
              height: 20,
            ),
            // TextFormField(
            //   controller: controller.descC,
            //   decoration:
            //       kTextFieldDecoration.copyWith(labelText: "Description"),
            //   onChanged: (value) => controller.descC.text = value,
            // ),
            // SizedBox(
            //   height: 20,
            // ),
            ElevatedButton(
                onPressed: () {
                  // controller.submit();
                },
                child: Text("Save"))
          ]),
        ),
      ),
    );
  }
}
