// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:discover_meet/src/models/Option_model.dart';
import 'package:discover_meet/src/models/question_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChooseUWidget extends StatefulWidget {
  final QuestionModel questionModel;
  const ChooseUWidget({super.key, required this.questionModel});

  @override
  State<ChooseUWidget> createState() => _ChooseUWidgetState();
}

class _ChooseUWidgetState extends State<ChooseUWidget> {
  @override
  Widget build(BuildContext context) {
    List<OptionModel> opts = widget.questionModel.options;
    OptionModel? _optSelected;
    return ListView.builder(
        itemCount: widget.questionModel.options.length,
        itemBuilder: (context, index) {
          return RadioListTile<OptionModel?>.adaptive(
              value: opts[index],
              groupValue: _optSelected,
              onChanged: (value) {
                setState(() {
                  _optSelected = value;
                });
              },
              title: Text(opts[index].opt));
        });
  }
}
