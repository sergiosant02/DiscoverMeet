import 'dart:developer' as dev;

import 'package:discover_meet/src/connections/questionnaire_connection.dart';
import 'package:discover_meet/src/custom_widgets/app_bar_discover.dart';
import 'package:discover_meet/src/custom_widgets/questionnaire_widget.dart';
import 'package:discover_meet/src/models/room_model.dart';
import 'package:discover_meet/src/utils/interface_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../models/questionnaire_model.dart';

class QuestionnaireListPage extends StatefulWidget {
  final String roomId;
  const QuestionnaireListPage({super.key, required this.roomId});

  @override
  State<QuestionnaireListPage> createState() => _QuestionnaireListPageState();
}

class _QuestionnaireListPageState extends State<QuestionnaireListPage> {
  QuestionnaireConnection _questionnaireConnection = QuestionnaireConnection();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: InterfaceColors.backgroundColor,
      appBar: AppBarDiscover.build(context, false),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 3.0, left: 15, right: 15, bottom: 3),
        child: FutureBuilder(
            future:
                _questionnaireConnection.getQuestionnairesOfRoom(widget.roomId),
            builder: (BuildContext context,
                AsyncSnapshot<List<QuestionnaireModel>> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                    child: CircularProgressIndicator.adaptive());
              } else if (snapshot.hasError) {
                return Center(
                    child: Text('Error: ' + snapshot.error.toString()));
              } else {
                List<QuestionnaireModel> data = snapshot.data!;
                if (data.isEmpty) {
                  return const Center(
                      child: Text('Aun no se han publicado cuestionarios'));
                }

                return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, i) {
                      return QuestionnaireWidget(
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
