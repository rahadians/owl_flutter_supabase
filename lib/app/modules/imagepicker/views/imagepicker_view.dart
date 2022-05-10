import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:owl_flutter/app/assets/models/constant.dart';

import '../controllers/imagepicker_controller.dart';

class ImagepickerView extends GetView<ImagepickerController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ImagepickerView'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(top: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(() => controller.selectedImagePath.value == ''
                    ? Text(
                        'Pilih gambar dari camera/gallery',
                        style: TextStyle(fontSize: 20),
                      )
                    : Image.file(File(controller.selectedImagePath.value))),
                ElevatedButton(
                  onPressed: () {
                    controller.getImage(ImageSource.camera);
                  },
                  child: Text("Camera"),
                ),
                SizedBox(
                  height: 10,
                ),
                Obx(
                  () => Text(
                    controller.selectedImageSize.value == ''
                        ? ''
                        : controller.selectedImageSize.value,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    controller.getImage(ImageSource.gallery);
                  },
                  child: Text("Gallery"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
