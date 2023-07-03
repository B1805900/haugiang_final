import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../common/constant.dart';
import '../../../data/models/survey.dart';
import '../../../routes/app_pages.dart';
import '../../survey_detail/controllers/survey_detail_controller.dart';
import '../controllers/dashboard_controller.dart';

import 'constants.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          color: Colors.white,
          // decoration: const BoxDecoration(
          //   image: DecorationImage(
          //     image: AssetImage('assets/images/background.jpg'), // Đường dẫn đến ảnh nền
          //     fit: BoxFit.fill, // Cách ảnh nền được hiển thị trong Container
          //   ),
          // ),
          child: AppBar(
            title: const Text('Danh sách khảo sát', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
            backgroundColor: primaryColor,
            
          ),
        ),
      ),
      drawer: buildDrawer(context),
      body: FutureBuilder<Widget>(
        future: buildSurveyList(context),
        builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Đã xảy ra lỗi: ${snapshot.error}'));
          } else {
            return snapshot.data!;
          }
        },
      ),
    );
  }


  Future<Widget> buildSurveyList(BuildContext context) async {
  List<SurveyModel> surveyList = await controller.fetchData();
  if (surveyList.isEmpty) {
    // ignore: use_build_context_synchronously
    return buildNullList(context);
  } else {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5),
        child: Container(
          color: Colors.white,
        //   decoration: const BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage('assets/images/background.jpg'), // Đường dẫn đến ảnh nền
        //     fit: BoxFit.cover, // Cách ảnh nền được hiển thị trong Container
        //   ),
        // ),
        child: RefreshIndicator(
          onRefresh: () async {
            surveyList = await controller.fetchData();
          },
          child: ListView(
            children: surveyList.map((survey) {
              return InkWell(
                onTap: () {
                  final SurveyDetailController myController = Get.put(SurveyDetailController());
                  myController.idSurveyNum = survey.idSurvey;
                  myController.nameSurveytitle = survey.nameSurvey;
                 // print(survey.idSurvey);
                  Get.toNamed(Routes.SURVEY_DETAIL);
                },
                child: Container(
                  padding: const EdgeInsets.only(top: 8),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.transparent, // Màu nền của Container
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey, width: 3),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.text_snippet, color: primaryColor),
                            const SizedBox(width: 8),
                            SizedBox(
                              width: Get.width * 0.8,
                              child: Text(
                                "Khảo sát: ${survey.nameSurvey}",
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: texColor,
                                  fontWeight: FontWeight.bold, // In đậm
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.lock_clock, color: primaryColor),
                            const SizedBox(width: 8),
                            Text(
                              "Thời gian kết thúc: ${survey.timeEnd}",
                              style: const TextStyle(
                                fontSize: 18,
                                color: texColor,
                              //  fontWeight: FontWeight.bold, // In đậm
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
        
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}


  Widget buildDrawer(BuildContext context) {
    return Column(children: [
      Expanded(
        child: Drawer(
          child: Material(
            child: ListView(
              children: <Widget>[
                buildMenuItem(
                    text: 'Thoát',
                    icon: Icons.logout,
                    iconColor: Colors.black,
                    onPressed: () {
                      // SystemNavigator.pop();
                      Get.back();
                      Get.back();
                    }),
              ],
            ),
          ),
        ),
      )
    ]);
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    required iconColor,
    required GestureTapCallback onPressed,
  }) {
    const hoverColor = Colors.white70;
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(
        text,
        style: largeTextStyle,
      ),
      hoverColor: hoverColor,
      onTap: onPressed,
    );
  }

  Widget buildNullList(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(), // Cho phép thao tác kéo
      child: RefreshIndicator(
        onRefresh: () async {
          // Thực hiện các tác vụ cần thiết để reload lại module ở đây
          Get.snackbar(
            "Lưu dữ liệu không thành công!",
            "Vui lòng nhập lại thông tin hợp lệ",
            shouldIconPulse: true,
            animationDuration: const Duration(seconds: 7),
            colorText: Colors.red,
            backgroundColor: Colors.yellow,
          );
        },
        child: Container(
          margin: const EdgeInsets.only(top: 20),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 235, 107, 104),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              const CircleAvatar(
                child: Image(
                  image: AssetImage('assets/images/logo.png'),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(50, 0, 0, 0),
                child: const Text(
                  'Hiện chưa có khảo sát!',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
