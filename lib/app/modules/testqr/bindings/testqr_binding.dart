import 'package:get/get.dart';

import '../controllers/testqr_controller.dart';

class TestqrBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TestqrController>(
      () => TestqrController(),
    );
  }
}
