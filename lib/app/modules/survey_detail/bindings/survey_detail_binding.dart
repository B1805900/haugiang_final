import 'package:get/get.dart';

import '../controllers/survey_detail_controller.dart';

class SurveyDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SurveyDetailController>(
      () => SurveyDetailController(),
    );
  }
}
