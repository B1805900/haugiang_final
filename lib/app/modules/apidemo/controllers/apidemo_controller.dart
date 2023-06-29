import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Question {
  String questionText;
  List<String> answers;
  int nextQuestionIndex;
  String group;

  Question(
      {required this.questionText,
      required this.answers,
      required this.nextQuestionIndex,
      required this.group});
}

List<Question> questions = [
  Question(
      questionText: "Câu hỏi 1",
      answers: ["Trả lời 1", "Trả lời 2"],
      nextQuestionIndex: 1,
      group: "A"),
  Question(
      questionText: "Câu hỏi 2",
      answers: ["Trả lời 3", "Trả lời 4"],
      nextQuestionIndex: 2,
      group: "A"),
  Question(
      questionText: "Câu hỏi 3",
      answers: ["Trả lời 3", "Trả lời 4"],
      nextQuestionIndex: 3,
      group: "A"),
  Question(
      questionText: "Câu hỏi 4",
      answers: ["Trả lời 3", "Trả lời 4"],
      nextQuestionIndex: 4,
      group: "A"),
  Question(
      questionText: "Câu hỏi 5",
      answers: ["Trả lời 3", "Trả lời 4"],
      nextQuestionIndex: 5,
      group: "A"),
  Question(
      questionText: "Câu hỏi 6",
      answers: ["Trả lời 3", "Trả lời 4"],
      nextQuestionIndex: 6,
      group: "B"),
  Question(
      questionText: "Câu hỏi 7",
      answers: ["Trả lời 3", "Trả lời 4"],
      nextQuestionIndex: 7,
      group: "B"),
  Question(
      questionText: "Câu hỏi 8",
      answers: ["Trả lời 3", "Trả lời 4"],
      nextQuestionIndex: 8,
      group: "B"),
  Question(
      questionText: "Câu hỏi 9",
      answers: ["Trả lời 3", "Trả lời 4"],
      nextQuestionIndex: 9,
      group: "B"),
  Question(
      questionText: "Câu hỏi 10",
      answers: ["Trả lời 3", "Trả lời 4"],
      nextQuestionIndex: 10,
      group: "B"),
  // Thêm các câu hỏi khác...
];

class ApidemoController extends GetxController {
  void showMyDialog(String mess) {
    Get.dialog(
      AlertDialog(
        title: const Text('Thông báo'),
        content: Text(mess),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Get.back(result: 'Đóng');
            },
            child: const Text('Đóng'),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }
}
