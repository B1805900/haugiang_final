import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import '../../../data/models/survey.dart';
import 'package:http/http.dart' as http;


class DashboardController extends GetxController {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Future<List<SurveyModel>> fetchData() async {
    var propertyList = <Map<String, dynamic>>[].obs;
    List<SurveyModel> surveyList = [];
    try {
      var url = Uri.parse('http://139.180.145.98:8080/survey.php');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonDataList = jsonString.split('}{');
        jsonDataList = jsonDataList.map((jsonString) {
          if (!jsonString.startsWith('{')) jsonString = '{' + jsonString;
          if (!jsonString.endsWith('}')) jsonString += '}';
          return jsonString;
        }).toList();

        var properties = <Map<String, dynamic>>[];
        for (var jsonData in jsonDataList) {
          var property = json.decode(jsonData);
          properties.add(property);
          surveyList.add(SurveyModel(property['id_survey'], property['name_survey'], property['time_create']['date'].substring(0, 10), property['time_end']['date'].substring(0, 10), property['username']));
        }
        propertyList.value = properties;
      } else {
        //print('Lỗi khi gọi API: ${response.statusCode}');
        Get.snackbar(
          "Lỗi khi gọi API!", "Vui lòng liên hệ Quản trị viên",
          shouldIconPulse: true,
          animationDuration: const Duration(seconds: 7),
          colorText: Colors.red,
          backgroundColor: Colors.yellow);
      }
    } catch (e) {
    //  print('Lỗi khi gọi API: $e');
      Get.snackbar(
          "Kết nối không thành công!", "Vui lòng kiểm tra lại kết nối",
          shouldIconPulse: true,
          animationDuration: const Duration(seconds: 7),
          colorText: Colors.red,
          backgroundColor: Colors.yellow);
    }
    return surveyList;
  }

  //TODO: Implement DashboardController

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

}
