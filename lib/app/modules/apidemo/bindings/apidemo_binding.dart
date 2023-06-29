import 'package:get/get.dart';

import '../controllers/apidemo_controller.dart';

class ApidemoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApidemoController>(
      () => ApidemoController(),
    );
  }
}
