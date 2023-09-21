import 'package:discover_meet/src/models/questionnaire_model.dart';
import 'package:flutter/material.dart';

class QuestionnaireWidget extends StatelessWidget {
  final QuestionnaireModel questionnaire;
  final Function() onTap;
  const QuestionnaireWidget({
    Key? key,
    required this.questionnaire,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
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
          width: size.width * 0.8,
          height: 80,
          child: ListView(
            children: [
              ListTile(
                title: Text(
                  questionnaire.title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
                subtitle: Text(
                  'Descripción: ${questionnaire.description}',
                  style: const TextStyle(
                      fontWeight: FontWeight.normal, color: Colors.black54),
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
