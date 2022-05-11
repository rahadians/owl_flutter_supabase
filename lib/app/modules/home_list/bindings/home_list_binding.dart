import 'package:get/get.dart';

import '../controllers/home_list_controller.dart';

class HomeListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeListController>(
      () => HomeListController(),
    );
  }
}
