import 'package:get/get.dart';

import '../controllers/singin_controller.dart';

class SinginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SinginController>(
      () => SinginController(),
    );
  }
}
