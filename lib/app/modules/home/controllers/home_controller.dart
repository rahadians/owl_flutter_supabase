import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../assets/models/newsmodel.dart';

import '../../signup/controllers/signup_controller.dart';

class HomeController extends GetxController {
  RxString usernameAPI = "".obs;
  RxString idUser = "".obs;
  RxList allNewsData = List.empty().obs;
  RxString idNews = "".obs;

  RxBool isloading = false.obs;

  Future getNewsData() async {
    allNewsData.clear(); //menghapus data list
    isloading.value = true;

    SupabaseClient client = Supabase.instance.client;
    try {
      PostgrestResponse response = await client
          .from('tbl_news')
          .select()
          .order('id_news', ascending: true)
          .execute();

      final data = response.data;
      final error = response.status;

      List<NewsModel> dataNote =
          NewsModel.fromJsonList((response.data as List));

      allNewsData.value = List.from(dataNote);

      allNewsData.refresh();

      // print(allNewsData[0]["id_news"]);
      isloading.value = false;
    } catch (err) {
      print(err);
    }
  }
}
