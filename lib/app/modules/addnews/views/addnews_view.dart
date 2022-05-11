import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:owl_flutter/app/routes/app_pages.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../assets/models/constant.dart';
import '../controllers/addnews_controller.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'package:intl/intl.dart';

// "https://mnxjbshqqxhbadvuazxt.supabase.co/storage/v1/object/public/images/Mango Mojito.jpg",
SupabaseClient client = Supabase.instance.client;

class AddnewsView extends GetView<AddnewsController> {
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Get.offAllNamed(Routes.HOME);
            }),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                controller: controller.scanC,
                keyboardType: TextInputType.text,
                autocorrect: false,
                decoration:
                    kTextFieldDecoration.copyWith(labelText: "Code Scan"),
                onChanged: (value) => value = controller.scanC.text,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                controller: controller.titleC,
                keyboardType: TextInputType.text,
                autocorrect: false,
                decoration: kTextFieldDecoration.copyWith(labelText: "Title"),
                onChanged: (value) => value = controller.titleC.text,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                autocorrect: false,
                keyboardType: TextInputType.multiline,
                minLines: 2,
                maxLines: 5,
                maxLength: null, //menyesuaikan isi kontent
                controller: controller.contentC,
                decoration: kTextFieldDecoration.copyWith(
                  labelText: "Content",
                ),
                onChanged: (value) => value = controller.contentC.text,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                autocorrect: false,
                keyboardType: TextInputType.multiline,
                maxLength: null, //menyesuaikan isi kontent
                controller: controller.descC,
                decoration:
                    kTextFieldDecoration.copyWith(labelText: "Description"),
                onChanged: (value) => value = controller.descC.text,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: controller.dateC,
                keyboardType: TextInputType.datetime,
                decoration: kTextFieldDecoration.copyWith(
                  labelText: "Tanggal Berita",
                  hintText: "Masukkan Tanggal",
                ),
                onTap: () async {
                  DateTime date = DateTime(1900);
                  FocusScope.of(context).requestFocus(new FocusNode());
                  // Get.focusScope(date());
                  date = (await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100)))!;

                  // controller.dateC.text = dateformat(date.toIso8601String());
                  controller.dateC.text =
                      DateFormat('dd-MMM-yyyy').format(date);
                },
                onChanged: (value) => value = controller.dateC.text,
              ),
              SizedBox(
                height: 10,
              ),
              // Card(
              //   elevation: 6,
              //   shadowColor: Colors.white24,
              //   child: Padding(
              //     padding: const EdgeInsets.all(10.0),
              //     child: BarcodeWidget(
              //       drawText: true,
              //       height: 100,
              //       width: 100,
              //       data: controller.scanC.text,
              //       barcode: Barcode.qrCode(
              //         errorCorrectLevel: BarcodeQRCorrectionLevel.high,
              //       ),
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    controller.simpan();
                  },
                  child: Obx(
                    () => Text((controller.isLoadingadd.isTrue)
                        ? "Loading.."
                        : "Simpan"),
                  ))
            ]),
          ),
        ),
      ),
    );
  }
}
