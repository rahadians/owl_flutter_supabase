import 'package:get/get.dart';

import '../controllers/readme_news_controller.dart';

class ReadmeNewsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReadmeNewsController>(
      () => ReadmeNewsController(),
    );
  }
}
