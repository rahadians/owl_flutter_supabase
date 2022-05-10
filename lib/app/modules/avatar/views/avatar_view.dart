import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/avatar_controller.dart';

class AvatarView extends GetView<AvatarController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: () {
          print(controller.imageUrl.value == "" ? "Yes" : "no");
        }),
        appBar: AppBar(),
        body: Column(
          children: [
            if (controller.imageUrl.value == "" ||
                controller.imageUrl.value == null)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    width: 150,
                    height: 150,
                    color: Colors.grey,
                    child: const Center(
                      child: Text('No Image'),
                    ),
                  ),
                ),
              )
            else
              Obx(() => Image.network(
                    controller.imageUrl.value,
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  )),
            ElevatedButton(
              onPressed: controller.isLoading.value ? null : controller.upload,
              child: const Text('Upload'),
            ),
          ],
        ));
  }
}
