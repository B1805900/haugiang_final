import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/constant.dart';
import '../../../data/models/users.dart';
import '../../../routes/app_pages.dart';
import '../../survey_detail/controllers/survey_detail_controller.dart';

class SinginController extends GetxController {
  void showDialogMessagenew(String message) {
    Get.dialog(
      AlertDialog(
        title: const Text('Thông báo'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text(
              'Đóng',
              style: TextStyle(color: primaryColor, fontSize: 18),
            ),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }
  final ScrollController scrollController = ScrollController();
  //TODO: Implement SinginController
  final formKey = GlobalKey<FormState>();
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController cccdController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController adressController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController nationController = TextEditingController();
  final TextEditingController educationController = TextEditingController();
  final TextEditingController numpeopleController = TextEditingController();
  final TextEditingController numfemaleController = TextEditingController();
  final TextEditingController jobController = TextEditingController();
  final TextEditingController incomeController = TextEditingController();
  
  final List<String> genderOptions = ["Nam", "Nữ", "Khác"];
  final RxString selectedGender = "Nam".obs;

  List<int> numSelected = [0, ...List.generate(100, (index) => index + 1)];
  RxInt selectedAge = 18.obs;
  RxInt selectedNumpeople = 0.obs;
  RxInt selectedNumfemale = 0.obs;

  final TextEditingController textEditingController = TextEditingController();
  final TextEditingController typeAheadController = TextEditingController();
  final List<String> options = [
    'Option 1',
    'Option 2',
    'Option 3',
    'Option 4',
    'Option 5',
  ];

  UsersModel userInfo = UsersModel();

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

  var isLoading = false.obs;

  Future<void> saveUser1(UsersModel user) async {
    isLoading.value = true;

    // Thực hiện công việc lưu người dùng
    await saveUser(user);

    isLoading.value = false;
  }

  static Future<void> saveUser(UsersModel user) async {
    try {
      final url = Uri.parse('http://139.180.145.98:8080/saveUser.php');
      final body = json.encode(user.toJson());
      final headers = {'Content-Type': 'application/json'};

      final response = await http.post(url, body: body, headers: headers);

      if (response.statusCode == 200) {
        // Xử lý phản hồi thành công từ server
        // Chuyển đổi chuỗi JSON thành một danh sách đối tượng trong Dart
        List<dynamic> responseData = jsonDecode(response.body);
        // Kiểm tra xem chuyển đổi có thành công hay không
        if (responseData.isNotEmpty) {
          // Lấy giá trị newId từ danh sách đối tượng
          try {
            String newId = responseData[0]['newId'];
            SurveyDetailController myController = Get.put(SurveyDetailController());
            myController.cccdNum = newId;
            Get.toNamed(Routes.DASHBOARD);
          } catch (e) {
            Get.snackbar(
            "Lưu dữ liệu không thành công!", "Vui lòng thử lại",
            shouldIconPulse: true,
            animationDuration: const Duration(seconds: 7),
            colorText: Colors.red,
            backgroundColor: Colors.yellow);
          }
        } else {
          // Lỗi API trả về rỗng
          Get.snackbar(
          "Lưu dữ liệu không thành công!", "Vui lòng nhập lại thông tin hợp lệ",
          shouldIconPulse: true,
          animationDuration: const Duration(seconds: 7),
          colorText: Colors.red,
          backgroundColor: Colors.yellow);
        }
      } else {
        // Xử lý phản hồi không thành công từ server
        Get.snackbar(
          "Lỗi lưu dữ liệu (API)!", "Vui lòng liên hệ Quản trị viên",
          shouldIconPulse: true,
          animationDuration: const Duration(seconds: 7),
          colorText: Colors.red,
          backgroundColor: Colors.yellow);
      }
    } catch (e) {
      // Lỗi không kết nối được với API
      Get.snackbar(
          "Lỗi kết nối: ${e.toString()}", "Vui lòng kiểm tra lại kết nối mạng",
          shouldIconPulse: true,
          animationDuration: const Duration(seconds: 7),
          colorText: Colors.red,
          backgroundColor: Colors.yellow);
    }
  }

  Future<List<String>> getUsedservice () async {
    List<String> listService = [];
    try {
      var url = Uri.parse('http://139.180.145.98:8080/listService.php');
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
          listService.add((property['name_service']));
        }
      } else {
        listService.add("");
      }
    } catch (e) {
      listService.add("");
    }
    return listService;
  }
}
