import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:owl_flutter/app/assets/models/newsmodel.dart';
import 'package:owl_flutter/app/modules/readme_news/controllers/readme_news_controller.dart';

import '../../../assets/models/constant.dart';
import '../../home/controllers/home_controller.dart';
import '../controllers/editnews_controller.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class EditnewsView extends GetView<EditnewsController> {
  final homeC = Get.find<ReadmeNewsController>();

  var argRead = Get.arguments; //mengambil data dari model data

  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    controller.titleTextC.text = homeC.title.value;
    controller.contentTextC.text = homeC.content.value;
    controller.descTextC.text = homeC.description.value;

    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {}),
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            InkWell(
              onTap: () => controller.selectImage(ImageSource.gallery),
              child: GetBuilder<EditnewsController>(builder: (controller) {
                return Container(
                    width: double.infinity,
                    height: 200,
                    child: (controller.ambilGambar != null)
                        ? Container(
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                                // color: Colors.red,
                                ),
                            child: Image.file(
                              File(controller.ambilGambar!.path),
                              fit: BoxFit.cover,
                            ))
                        : Container(
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(),
                            child: Image(
                                image: AssetImage(
                                    'lib/app/assets/img/dummyimage.png'))));
                // ini kalau sudah bisa gambar di ganti di ambil dari gambar yang ada
              }),
            ),
            TextFormField(
              controller: controller.titleTextC,
              decoration: kTextFieldDecoration.copyWith(labelText: "Title"),
              onChanged: (value) => value = controller.title.value,
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              keyboardType: TextInputType.multiline,
              maxLength: null, //menyesuaikan isi kontent
              controller: controller.contentTextC,
              decoration: kTextFieldDecoration.copyWith(labelText: "Content"),
              onChanged: (value) => value = controller.content.value,
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: controller.descTextC,
              decoration:
                  kTextFieldDecoration.copyWith(labelText: "Description"),
              onChanged: (value) => value = controller.description.value,
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  controller.submit();
                },
                child: Text("Confirm"))
          ]),
        ),
      ),
    );
  }
}
