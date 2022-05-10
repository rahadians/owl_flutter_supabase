import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:owl_flutter/app/routes/app_pages.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  RxInt pilihan = 0.obs;

  selectIndex() {
    switch (pilihan.value) {
      case 0:
        {
          Timer(Duration(seconds: 2), () {
            Get.offAndToNamed(Routes.HOME_LIST);
          });
        }
        break;

      case 1:
        {
          Timer(Duration(seconds: 2), () {
            Get.toNamed(Routes.DETAIL_ITEM);
          });
        }
        break;

      case 2:
        {}
        break;
      case 3:
        {
          //statements;
        }
        break;
      case 4:
        {
          Timer(Duration(seconds: 2), () {
            Get.offAndToNamed(Routes.ADDNEWS);
          });
        }
        break;
    }
  }
}
