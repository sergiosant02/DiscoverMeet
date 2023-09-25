// ignore_for_file: prefer_final_fields

import 'package:discover_meet/src/connections/questionnaire_connection.dart';
import 'package:discover_meet/src/custom_widgets/app_bar_discover.dart';
import 'package:discover_meet/src/custom_widgets/my_questionnaire_widget.dart';
import 'package:discover_meet/src/utils/interface_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../models/questionnaire_model.dart';

class MyQuestionnaireListPage extends StatefulWidget {
  final String roomId;
  const MyQuestionnaireListPage({super.key, required this.roomId});

  @override
  State<MyQuestionnaireListPage> createState() =>
      _MyQuestionnaireListPageState();
}

class _MyQuestionnaireListPageState extends State<MyQuestionnaireListPage> {
  QuestionnaireConnection _questionnaireConnection = QuestionnaireConnection();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: InterfaceColors.principalColor,
        onPressed: () {},
        label: const Text(
          "Añadir questionario",
          style: TextStyle(color: Colors.white),
        ),
        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      backgroundColor: InterfaceColors.backgroundColor,
      appBar: AppBarDiscover.build(context, false),
      body: Container(
        width: size.width,
        padding:
            const EdgeInsets.only(top: 3.0, left: 15, right: 15, bottom: 3),
        child: FutureBuilder(
            future: _questionnaireConnection
                .getMyQuestionnairesOfRoom(widget.roomId),
            builder: (BuildContext context,
                AsyncSnapshot<List<QuestionnaireModel>> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                    child: CircularProgressIndicator.adaptive());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                List<QuestionnaireModel> data = snapshot.data!;
                if (data.isEmpty) {
                  return const Center(
                      child: Text('Aun no se han publicado cuestionarios'));
                }

                return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, i) {
                      return MyQuestionnaireWidget(
                          questionnaire: data[i],
                          onTap: () {
                            GoRouter.of(context).go(
                                "/${widget.roomId}/questionnaire/${data[i].id}/question");
                          });
                    });
              }
            }),
      ),
    );
  }
}
