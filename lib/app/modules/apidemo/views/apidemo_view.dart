import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/apidemo_controller.dart';

class ApidemoView extends GetView<ApidemoController> {
  const ApidemoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<List<Question>> questionGroups = groupQuestionsByGroup(questions);
    PageController pageController = PageController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Test'),
        centerTitle: true,
      ),
      body: PageView.builder(
        controller: pageController,
        itemCount: questionGroups.length,
        itemBuilder: (context, groupIndex) {
          List<Question> group = questionGroups[groupIndex];

          return ListView.builder(
            itemCount: group.length,
            itemBuilder: (context, index) {
              Question question = group[index];

              return Column(
                children: [
                  ListTile(
                    title: Text(
                      question.questionText,
                      style: const TextStyle(color: Colors.blue),
                    ),
                  ),
                  Column(
                    children: List.generate(
                      question.answers.length,
                      (answerIndex) => CheckboxListTile(
                        title: Text(question.answers[answerIndex]),
                        value: false, // Giá trị của checkbox
                        onChanged: (newValue) {
                          // Xử lý khi người dùng thay đổi trạng thái checkbox
                          int nextQuestionIndex = question.nextQuestionIndex;
                          if (nextQuestionIndex != null) {
                            // Chuyển tới câu hỏi tiếp theo trong group hiện tại
                            pageController.animateToPage(
                              index + 1,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                          } else {
                            // Xử lý khi không có câu hỏi tiếp theo trong group
                            // Chuyển tới group tiếp theo trong danh sách
                            pageController.animateToPage(
                              groupIndex + 1,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  List<List<Question>> groupQuestionsByGroup(List<Question> questions) {
    List<List<Question>> questionGroups = [];
    List<String> groups = questions.map((q) => q.group).toSet().toList();

    for (String group in groups) {
      List<Question> groupQuestions =
          questions.where((q) => q.group == group).toList();
      questionGroups.add(groupQuestions);
    }
    return questionGroups;
  }
}
