import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../assets/models/constant.dart';
import '../controllers/addnews_controller.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fluttertoast/fluttertoast.dart';

// "https://mnxjbshqqxhbadvuazxt.supabase.co/storage/v1/object/public/images/Mango Mojito.jpg",
SupabaseClient client = Supabase.instance.client;

class AddnewsView extends GetView<AddnewsController> {
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
          FloatingActionButton(heroTag: "btnbesar", onPressed: () {}),
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            Container(
              // onTap: () => controller.upload(),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Obx(
                      () => (controller.imageUrl.value == "" ||
                              controller.imageUrl.value == "")
                          ? Container(
                              width: double.infinity,
                              height: 200,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  "lib/app/assets/img/dummyimage.png",
                                  // "/data/user/0/com.example.owl_flutter/app_flutter/2022-05-06T10:32:23.274935.jpg",
                                  fit: BoxFit.contain,
                                ),
                              ),
                              decoration: BoxDecoration(
                                  border: Border.all(color: kLightgreen)),
                            )
                          : Container(
                              width: double.infinity,
                              height: 250,
                              child: (controller.filebytes != null)
                                  ? Image.memory(
                                      controller.filebytes,
                                      fit: BoxFit.fill,
                                    )
                                  : Image.asset(
                                      "lib/app/assets/img/girlimage.png"),
                            ),
                    ),
                  ),
                  Stack(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 20, bottom: 10),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: FloatingActionButton(
                            heroTag: "btnkecil",
                            autofocus: true,
                            mini: false,
                            onPressed: () {},
                            child: SpeedDial(
                              icon: Icons.add_a_photo,
                              // buttonSize: Size(10, 10),
                              backgroundColor: kDarkerGreen,
                              spacing: 5,
                              spaceBetweenChildren: 5,
                              closeManually: false,
                              children: [
                                SpeedDialChild(
                                    onTap: () {
                                      controller.upload(ImageSource.camera);
                                    },
                                    child: Icon(Icons.camera_alt)),
                                SpeedDialChild(
                                  onTap: () {
                                    controller.upload(ImageSource.gallery);
                                  },
                                  child: Icon(Icons.photo_album_outlined),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
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
