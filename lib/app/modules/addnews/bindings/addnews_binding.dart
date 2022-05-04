import 'package:get/get.dart';

import '../controllers/addnews_controller.dart';

class AddnewsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddnewsController>(
      () => AddnewsController(),
    );
  }
}
