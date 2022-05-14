import 'package:barcode_widget/barcode_widget.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
// import 'package:barcode_widget/barcode_widget.dart';
import 'package:path/path.dart';
import '../../../assets/models/constant.dart';
import '../controllers/detail_item_controller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DetailItemView extends GetView<DetailItemController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kLightgreen,
        appBar: AppBar(
          elevation: 5,
          actions: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: InkWell(
                onTap: () => controller.scanBarcode(),
                child: Container(
                  width: 160,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      border: Border.all(color: Colors.white)),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Scan Barcode",
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Icon(Icons.qr_code_scanner_outlined,
                            size: 18, color: Colors.blue)
                      ]),
                ),
              ),
            )
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Stack(children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                ),
                width: double.infinity,
              ),
              Column(children: [
                Container(
                  // onTap: () => controller.upload(),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Obx(() => BarcodeWidget(
                            barcode: Barcode.qrCode(
                              errorCorrectLevel: BarcodeQRCorrectionLevel.high,
                            ),
                            data: controller.isiBarcode.value,
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.white70,
                            ),
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                          onSubmitted: (value) =>
                              controller.cariData(controller.barcodeC.text),
                          controller: controller.barcodeC,
                          keyboardType: TextInputType.text,
                          autocorrect: false,
                          decoration: kTextFieldDecoration.copyWith(
                            labelText: "Code Item",
                          ),
                          onChanged: (value) =>
                              value = controller.isiBarcode.value),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Obx(() => TextFormField(
                      enabled: (controller.isEdit.isTrue) ? true : false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      controller: controller.titleC,
                      keyboardType: TextInputType.text,
                      autocorrect: false,
                      decoration:
                          kTextFieldDecoration.copyWith(labelText: "Title"),
                      onChanged: (value) => value = controller.titleC.text,
                    )),
                SizedBox(
                  height: 5,
                ),
                Obx(() => TextFormField(
                      enabled: (controller.isEdit.isTrue) ? true : false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      autocorrect: false,
                      keyboardType: TextInputType.text,

                      maxLength: null, //menyesuaikan isi kontent
                      controller: controller.contentC,
                      decoration: kTextFieldDecoration.copyWith(
                        labelText: "Content",
                      ),
                      onChanged: (value) => value = controller.contentC.text,
                    )),
                SizedBox(
                  height: 5,
                ),
                Obx(() => TextFormField(
                      enabled: (controller.isEdit.isTrue) ? true : false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      autocorrect: false,
                      keyboardType: TextInputType.text,
                      minLines: 1,
                      maxLines: 5,
                      maxLength: null, //menyesuaikan isi kontent
                      controller: controller.descC,
                      decoration: kTextFieldDecoration.copyWith(
                        labelText: "Description",
                      ),
                      onChanged: (value) => value = controller.descC.text,
                    )),
                SizedBox(
                  height: 5,
                ),
                Obx(() => TextFormField(
                      enabled: (controller.isEdit.isTrue) ? true : false,
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
                    )),
                SizedBox(
                  height: 10,
                ),

                //  Stack(
                //                       children: <Widget>[
                //                         Padding(
                //                           padding: const EdgeInsets.only(right: 20, bottom: 10),
                //                           child: Align(
                //                             alignment: Alignment.bottomCenter,
                //                             child: FloatingActionButton(
                //                               heroTag: "btnkecil",
                //                               autofocus: true,
                //                               mini: false,
                //                               onPressed: () {},
                //                               child: SpeedDial(
                //                                 icon: Icons.add_a_photo,
                //                                 // buttonSize: Size(10, 10),
                //                                 backgroundColor: kDarkerGreen,
                //                                 spacing: 5,
                //                                 spaceBetweenChildren: 5,
                //                                 closeManually: false,
                //                                 children: [
                //                                   SpeedDialChild(
                //                                       onTap: () {
                //                                         // controller.upload(ImageSource.camera);
                //                                       },
                //                                       child: Icon(Icons.camera_alt)),
                //                                   SpeedDialChild(
                //                                     onTap: () {
                //                                       // controller.upload(ImageSource.gallery);
                //                                     },
                //                                     child: Icon(Icons.photo_album_outlined),
                //                                   ),
                //                                 ],
                //                               ),
                //                             ),
                //                           ),
                //                         ),
                //                       ],
                //                     )

                // Padding(
                // padding: const EdgeInsets.all(5.0),
                // child: Obx(
                //   () => (controller.imageUrl.value == "" ||
                //           controller.imageUrl.value == "")
                //       ? Container(
                //           width: double.infinity,
                //           height: 200,
                //           child: Padding(
                //             padding: const EdgeInsets.all(8.0),
                //             child: Image.asset(
                //               "lib/app/assets/img/dummyimage.png",
                //               // "/data/user/0/com.example.owl_flutter/app_flutter/2022-05-06T10:32:23.274935.jpg",
                //               fit: BoxFit.contain,
                //             ),
                //           ),
                //           decoration: BoxDecoration(
                //               border: Border.all(color: kLightgreen)),
                //         )
                //       : Container(
                //           width: double.infinity,
                //           height: 250,
                //           child: (controller.filebytes != null)
                //               ? Image.memory(
                //                   controller.filebytes,
                //                   fit: BoxFit.cover,
                //                 )
                //               : Image.asset(
                //                   "lib/app/assets/img/girlimage.png"),
                //         ),
                // ),
                // ),
                // SizedBox(height:20),
                ElevatedButton(
                  onPressed: () {
                    controller.onUpdate();
                  },
                  child: Obx(
                    () => Text(
                        (controller.isLoading.isTrue) ? "Loading.." : "Simpan"),
                  ),
                ),
              ]),
            ]),
          ),
        ),
        bottomNavigationBar: ConvexAppBar(
            style: TabStyle.textIn,
            items: [
              TabItem(icon: Icons.edit, title: 'Edit'),
              TabItem(icon: Icons.search_outlined, title: 'Search'),
              TabItem(icon: Icons.delete_forever, title: 'Remove'),
            ],
            initialActiveIndex: 1, //optional, default as 0
            onTap: (int i) {
              controller.pilihan.value = i;
              controller.selectIndex();
            }));
  }
}
