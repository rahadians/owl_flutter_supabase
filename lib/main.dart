import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import './app/assets/models/constant.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  // final globalCtrl = Get.put(PublicControllerController());
  Supabase supabase = await Supabase.initialize(
    url: BaseUrl.cBaseUrl,
    anonKey: BaseUrl.cAnonKey,
  );
  final SupabaseClient clients =
      SupabaseClient(BaseUrl.cBaseUrl, BaseUrl.cAnonKey);
  // print("==================");
  // print(supabase.client.auth.session()?.toJson());

  runApp(GetMaterialApp(
    theme: ThemeData(
        primaryColor: kLightgreen,
        iconTheme: IconThemeData(color: Colors.greenAccent)),
    debugShowCheckedModeBanner: false,
    title: "Application",
    initialRoute: Routes.LOGIN,
    // supabase.client.auth.currentUser == null ? Routes.LOGIN : Routes.HOME,
    // supabase.client.auth.currentUser == null ? "kosong" : "isi",
    getPages: AppPages.routes,
  ));
}
