// ignore_for_file: prefer_final_fields

import 'package:discover_meet/src/connections/questionnaire_connection.dart';
import 'package:discover_meet/src/models/questionnaire_model.dart';
import 'package:discover_meet/src/providers/page_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class MyQuestionnaireWidget extends StatelessWidget {
  final QuestionnaireModel questionnaire;
  final Function() onTap;
  MyQuestionnaireWidget({
    Key? key,
    required this.questionnaire,
    required this.onTap,
  }) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  QuestionnaireConnection _questionnaireConnection = QuestionnaireConnection();
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final PageProvider pageProvider = Provider.of<PageProvider>(context);
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 0.8,
            spreadRadius: 0.2,
          )
        ], color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: SizedBox(
          width: size.width,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 150,
                width: size.width * 0.5,
                child: ListView(
                  children: [
                    ListTile(
                      title: Text(
                        questionnaire.title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Descripción: ${questionnaire.description}',
                            style: const TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.black54),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text("Intentos: ${questionnaire.intents}"),
                          Text("Frecuencia: ${questionnaire.frecuencia}"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  questionnaire.draftmode
                      ? TextButton(
                          onPressed: () {
                            _questionnaireConnection
                                .publishQuestionnaire(questionnaire.id);
                            _executeAction(pageProvider, context,
                                "Cuestionario publicado");
                          },
                          child: const Text("Publicar"))
                      : Container(),
                  TextButton(
                    onPressed: () {
                      if (!questionnaire.enable) {
                        _questionnaireConnection
                            .setEnableQuestionnaire(questionnaire.id);
                        _executeAction(
                            pageProvider, context, "Cuestionario habilitado");
                      } else {
                        _questionnaireConnection
                            .setUnableQuestionnaire(questionnaire.id);
                        _executeAction(
                            pageProvider, context, "Cuestionario inabilitado");
                      }
                    },
                    child: questionnaire.enable
                        ? const Text("Habilitar")
                        : const Text("Deshabilitar"),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: const Text("Listado de preguntas")),
                  TextButton(
                      onPressed: () async {
                        await _questionnaireConnection
                            .deleteQuestionnaire(questionnaire.id);
                        _executeAction(
                            pageProvider, context, "Cuestionario eliminado");
                      },
                      child: const Text("Eliminar cuestionario")),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _executeAction(
      PageProvider pageProvider, BuildContext context, String txt) {
    pageProvider.page = 1;
    context.go("/${questionnaire.roomId}/questionnaire/mine");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(txt)),
    );
  }
}
