// ignore_for_file: prefer_final_fields

import 'package:discover_meet/src/connections/question_connection.dart';
import 'package:discover_meet/src/custom_widgets/app_bar_discover.dart';
import 'package:discover_meet/src/models/answer_model.dart';
import 'package:discover_meet/src/pages/Question/question_page.dart';
import 'package:flutter/material.dart';

import '../../models/question_model.dart';

class QuestionListPage extends StatefulWidget {
  final String questionnaireId;
  const QuestionListPage({super.key, required this.questionnaireId});

  @override
  State<QuestionListPage> createState() => _QuestionListPageState();
}

class _QuestionListPageState extends State<QuestionListPage> {
  QuestionConnection _questionConnection = QuestionConnection();
  List<AnswerModel> answers = [];
  PageController _pageController = PageController(
    initialPage: 0,
  );

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDiscover.build(context, false, showBackButton: false),
      body: FutureBuilder(
          future: _questionConnection.getQuestions(widget.questionnaireId),
          builder: (BuildContext context,
              AsyncSnapshot<List<QuestionModel>> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.data == null || snapshot.data!.isEmpty) {
              return const Center(
                child: Text('No questions found'),
              );
            } else {
              List<QuestionModel> data = snapshot.data!;
              return PageView.builder(
                controller: _pageController,
                itemCount: data.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, i) {
                  return QuestionPage(
                      questionModel: data[i],
                      index: i,
                      pageController: _pageController,
                      dataSize: data.length,
                      answers: answers);
                },
              );
            }
          }),
    );
  }
}
