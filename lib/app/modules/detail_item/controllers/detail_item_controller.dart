import 'dart:async';
import 'dart:convert';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../assets/models/tablenews.dart';
import '../../../routes/app_pages.dart';

class DetailItemController extends GetxController {
  SupabaseClient client = Supabase.instance.client;
  RxString scanResult = "".obs;
  RxString isiBarcode = "".obs;
  RxBool isLoading = false.obs;
  RxInt pilihan = 0.obs;
  RxList allGetData = List.empty().obs;
  RxBool isEdit = false.obs;
  RxInt noId = 0.obs;

  @override
  final titleC = TextEditingController();
  final contentC = TextEditingController();
  final descC = TextEditingController();
  final dateC = TextEditingController();
  final barcodeC = TextEditingController();

  selectIndex() {
    switch (pilihan.value) {
      case 0:
        {
          isEdit.value = true;
        }
        break;

      case 1:
        {
          Timer(Duration(milliseconds: 200), () {
            scanBarcode();
          });
        }
        break;
      case 2:
        {
          onRemove();
        }
        break;
    }
  }

  Future<dynamic> scanBarcode() async {
    isEdit.value = false;
    try {
      scanResult.value = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666",
        "Cancel",
        true,
        ScanMode.QR,
      );
      if (scanResult.value == "-1") {
        barcodeC.text = "";
      } else {
        barcodeC.text = scanResult.value;
        isiBarcode.value = scanResult.value;
        cariData(scanResult.value.toString());
      }
    } on PlatformException catch (error) {
      print(error);
    }
    // if (!mounted) return;
  }

  Future<dynamic> simpan() async {
    // if (!mounted) return;
  }

  Future<dynamic> cariData(String nilai) async {
    try {
      // PostgrestResponse<dynamic> result = await client
      //     .from("tbl_news")
      //     .select('id_news,content,title,created_at,')
      //     .match({"code_item": 'cu7YzTg03MrcuDZE'}).execute();

      // PostgrestResponse<dynamic> result =
      //     await client.from('profiles').select().execute();

      PostgrestResponse<dynamic> result = await client
          .from('tbl_news')
          .select('')
          .match({'code_item': nilai}).execute();

      final data = result.data;
      final error = result.error;
      List<TableNews> dataNote = TableNews.fromJsonList(result.data as List);

      allGetData.value = List.from(dataNote);

      allGetData.refresh();
      for (var item in allGetData.value) {
        noId.value = item.idNews;
        titleC.text = item.title;
        contentC.text = item.content;
        descC.text = item.description;
        // dateC.text = item.dateNews.substring(0, 10);
        DateTime tanggal = DateTime.parse(item.dateNews);
        dateC.text = DateFormat('dd-MMM-yyyy').format(tanggal);
      }
    } catch (err) {
      print("err");
    }
  }

  Future<void> onUpdate() async {
    isLoading.value = true;
    print(noId.value);

    try {
      PostgrestResponse<dynamic> result = await client.from("tbl_news").update({
        "code_item": isiBarcode.value,
        "title": titleC.text,
        "content": contentC.text,
        "description": descC.text,
        "date_news": dateC.text,
      }).match({"id_news": noId.value}).execute();
      print(result.status);

      isLoading.value = false;
    } catch (err) {
      print(err);
    }
  }

  Future onRemove() async {
    isLoading.value = true;
    Get.defaultDialog(
        title: "Warning \u{26A0}",
        middleText: "Are you sure to delete this item?",
        textCancel: "Cancel",
        onCancel: () {
          Get.back();
        },
        textConfirm: "Yes",
        onConfirm: () async {
          try {
            print(noId.value);
            await client
                .from("tbl_news")
                .delete()
                .match({"id_news": noId.value}).execute();
            clear();
            Get.back();
          } catch (err) {
            print(err);
          }
        });
    isLoading.value = false;
  }

  void clear() {
    titleC.clear();
    contentC.clear();
    descC.clear();
    dateC.clear();
    barcodeC.clear();
  }
}
