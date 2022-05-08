import 'package:get/get.dart';

import '../controllers/home_grid_view_controller.dart';

class HomeGridViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeGridViewController>(
      () => HomeGridViewController(),
    );
  }
}
