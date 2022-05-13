import 'dart:async';

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
  RxBool isLoadingadd = false.obs;
  RxInt pilihan = 0.obs;
  RxList allGetData = List.empty().obs;

  final titleC = TextEditingController();
  final contentC = TextEditingController();
  final descC = TextEditingController();
  final dateC = TextEditingController();
  final barcodeC = TextEditingController();

  selectIndex() {
    switch (pilihan.value) {
      case 0:
        {
          Timer(Duration(milliseconds: 200), () {
            Get.offAndToNamed(Routes.HOME_LIST);
          });
        }
        break;

      case 1:
        {
          Timer(Duration(milliseconds: 200), () {
            Get.toNamed(Routes.DETAIL_ITEM);
          });
        }
        break;
    }
  }

  Future<dynamic> scanBarcode() async {
    try {
      scanResult.value = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666",
        "Cancel",
        true,
        ScanMode.QR,
      );
      barcodeC.text = scanResult.value;
      cariData(scanResult.value.toString());
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
        titleC.text = item.title;
        contentC.text = item.content;
        descC.text = item.description;
        print(item.dateNews);
        dateC.text = item.dateNews.substring(0, 10);
        ;
      }
    } catch (err) {
      print("err");
    }
  }

  // void clear() {
  //   titleC.clear();
  //   contentC.clear();
  //   descC.clear();
  //   dateC.clear();
  //   barcodeC.clear();
  // }
}
