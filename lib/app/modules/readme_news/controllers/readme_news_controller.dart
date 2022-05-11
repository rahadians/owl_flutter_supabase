import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:owl_flutter/app/assets/models/newsmodel.dart';

class ReadmeNewsController extends GetxController {
  RxString imgUrl = ''.obs;
  RxString newModelImg = ''.obs;
  RxString newsModelTitle = ''.obs;
  RxString newsModelContent = ''.obs;
  RxString idNews = "".obs;
  RxString title = "".obs;
  RxString content = "".obs;
  RxString description = "".obs;

  RxList newsList = [].obs;

  @override
  void onClose() {
    // TODO: implement onClose

    super.onClose();
  }
}
