// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:discover_meet/src/connections/answer_connection.dart';
import 'package:discover_meet/src/custom_widgets/option_box_widget.dart';
import 'package:discover_meet/src/models/Option_model.dart';
import 'package:discover_meet/src/models/QuestionType.dart';
import 'package:discover_meet/src/models/answer_model.dart';
import 'package:discover_meet/src/models/question_model.dart';
import 'package:discover_meet/src/utils/interface_colors.dart';
import 'package:discover_meet/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../custom_widgets/custom_button.dart';
import '../../providers/page_provider.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage(
      {super.key,
      required this.questionModel,
      required this.index,
      required this.pageController,
      required this.dataSize,
      required this.answers});
  final QuestionModel questionModel;
  final int index;
  final PageController pageController;
  final int dataSize;
  final List<AnswerModel> answers;

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  double _value = 0.0;
  TextEditingController textEditingControllerNumber = TextEditingController();
  TextEditingController textEditingController = TextEditingController();
  OptionModel? _optOptionSelected;
  final List<bool> _optOptionsSelected = [];
  String _textAnswer = "";
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();

    if (widget.questionModel.minValue != null) {
      _value = widget.questionModel.minValue! * 1.0;
    }
    textEditingControllerNumber.text = _value.toStringAsFixed(1);
    for (var i = 0; i < widget.questionModel.options.length; i++) {
      _optOptionsSelected.add(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final PageProvider _pageProvider = Provider.of<PageProvider>(context);
    final String nextButtonText = widget.index != widget.dataSize - 1
        ? "Siguiente pregunta"
        : "Finalizar";
    return Form(
      key: _formKey,
      child: Container(
          color: InterfaceColors.backgroundColor,
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              questionPoster(context, size),
              if (![QuestionType.FLT, QuestionType.INT, QuestionType.TXT]
                  .contains(widget.questionModel.type.type)) ...[
                if (QuestionType.CHOOSEU == widget.questionModel.type.type) ...[
                  // Pantalla de selección única
                  questionChooseUnique(context, size)
                ] else if (QuestionType.CHOOSEM ==
                    widget.questionModel.type.type) ...[
                  //Pantalla de selección multiple
                  questionChooseMultiple(context, size)
                ]
              ] else if (widget.questionModel.type.type ==
                  QuestionType.TXT) ...[
                answerTextFiel(context, size),
              ] else ...[
                // Pantalla de introducción de INT y FLT
                SizedBox(
                  height: size.height * 0.45,
                  width: size.width * 0.95,
                  child: ListView(children: [
                    maxAndMinLabels(context, size),
                    intAndFltField(context, size),
                  ]),
                )
              ],
              CustomButton(
                  heightPercent: 0.05,
                  widthPercent: 0.7,
                  action: () {
                    if (widget.questionModel.type.type ==
                            QuestionType.CHOOSEU &&
                        _optOptionSelected == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          duration: Duration(milliseconds: 400),
                          content: Text("Debe seleccionar una opción"),
                        ),
                      );
                    } else if (widget.questionModel.type.type ==
                            QuestionType.CHOOSEM &&
                        !_optOptionsSelected.contains(true)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          duration: Duration(milliseconds: 400),
                          content: Text("Debe seleccionar al menos una opción"),
                        ),
                      );
                    } else if (_formKey.currentState != null &&
                        _formKey.currentState!.validate()) {
                      AnswerModel answer = AnswerModel(
                          value: [], question: widget.questionModel);
                      setState(() {
                        if (widget.questionModel.type.type ==
                            QuestionType.CHOOSEM) {
                          for (int i = 0; i < _optOptionsSelected.length; i++) {
                            bool ans = _optOptionsSelected[i];
                            if (ans) {
                              OptionModel optAnswered =
                                  widget.questionModel.options[i];
                              answer.value.add(optAnswered);
                            }
                          }
                        } else if (widget.questionModel.type.type ==
                                QuestionType.CHOOSEU &&
                            _optOptionSelected != null) {
                          answer.value.add(_optOptionSelected!);
                        } else if ([QuestionType.INT, QuestionType.FLT]
                            .contains(widget.questionModel.type.type)) {
                          OptionModel optAnswered =
                              OptionModel(opt: _value.toString());
                          answer.value.add(optAnswered);
                        } else {
                          OptionModel optAnswered =
                              OptionModel(opt: _textAnswer);
                          answer.value.add(optAnswered);
                        }

                        widget.answers.add(answer);
                        print(widget.answers);
                      });

                      //Enviar la respuesta o pasar a la siguiente pregunta

                      if (widget.index == widget.dataSize - 1) {
                        context.go("/");
                        _pageProvider.page = 0;
                        AnswerConnection answerConnection = AnswerConnection();
                        answerConnection.postAnswerList(widget.answers);
                      } else {
                        widget.pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.linear);
                      }
                    }
                  },
                  textButton: nextButtonText)
            ],
          )),
    );
  }

// Cartel que muestra la pregunta
  Widget questionPoster(BuildContext context, Size size) {
    return Container(
      width: size.width * 0.95,
      height: size.height * 0.3,
      margin: const EdgeInsets.only(top: 8, bottom: 20),
      padding: const EdgeInsets.all(10),
      alignment: Alignment.center,
      decoration: BoxDecoration(boxShadow: const [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 0.8,
          spreadRadius: 0.2,
        )
      ], color: Colors.white, borderRadius: BorderRadius.circular(5)),
      child: Text(
        widget.questionModel.title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget questionChooseUnique(BuildContext context, Size size) {
    return SizedBox(
      height: size.height * 0.45,
      width: size.width * 0.95,
      child: ListView.builder(
          itemCount: widget.questionModel.options.length,
          itemBuilder: (context, i) {
            return OptionBox(
              child: RadioListTile.adaptive(
                  value: widget.questionModel.options[i],
                  groupValue: _optOptionSelected,
                  onChanged: (value) {
                    setState(() {
                      _optOptionSelected = value;
                    });
                  },
                  title: Text(widget.questionModel.options[i].opt)),
            );
          }),
    );
  }

  Widget questionChooseMultiple(BuildContext context, Size size) {
    return SizedBox(
      height: size.height * 0.45,
      width: size.width * 0.95,
      child: ListView.builder(
          itemCount: widget.questionModel.options.length,
          itemBuilder: (context, i) {
            return OptionBox(
              child: CheckboxListTile.adaptive(
                  value: _optOptionsSelected[i],
                  onChanged: (value) {
                    setState(() {
                      _optOptionsSelected[i] = value ?? false;
                    });
                  },
                  title: Text(widget.questionModel.options[i].opt)),
            );
          }),
    );
  }

  Widget maxAndMinLabels(BuildContext context, Size size) {
    return SizedBox(
      height: 100,
      width: size.width * 0.95,
      child: Row(
        children: [
          Column(
            children: [
              const Text(
                "Valor mínimo",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(widget.questionModel.minValue.toString()),
            ],
          ),
          const Spacer(),
          Column(
            children: [
              const Text(
                "Valor máximo",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(widget.questionModel.maxValue.toString()),
            ],
          )
        ],
      ),
    );
  }

  Widget intAndFltField(BuildContext context, Size size) {
    return Center(
        child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomButton(
          heightPercent: 0.1,
          widthPercent: 0.1,
          action: () {
            setState(() {
              if (widget.questionModel.type.type == QuestionType.INT) {
                _value -= 1;
              } else if (widget.questionModel.type.type == QuestionType.FLT) {
                _value -= 0.1;
              }
              textEditingControllerNumber.text = _value.toStringAsFixed(1);
            });
          },
          textButton: "-",
          height: 57,
          width: 56,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          height: 100,
          width: size.width * 0.4,
          child: TextFormField(
            controller: textEditingControllerNumber,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
                fillColor: Colors.white, // Cambia este color al que desees
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.zero,
                  borderSide: BorderSide(
                    color: Colors.blue, // Color del borde
                    width: 2.0, // Ancho del borde
                  ),
                )),
            onChanged: (value) {
              _value = double.tryParse(value) ??
                  widget.questionModel.minValue! * 1.0;
            },
            validator: (value) {
              if (widget.questionModel.type.type == QuestionType.INT) {
                if (Utils.isNumeric(value!) ||
                    _value < widget.questionModel.minValue! ||
                    _value > widget.questionModel.maxValue!) {
                  return "El valor debe ser un número entero entre ${widget.questionModel.minValue} y ${widget.questionModel.maxValue}";
                }
              }
              if (widget.questionModel.type.type == QuestionType.FLT) {
                if (Utils.isNumeric(value!) ||
                    _value < widget.questionModel.minValue! ||
                    _value > widget.questionModel.maxValue!) {
                  return "El valor debe ser un número decimal entre ${widget.questionModel.minValue} y ${widget.questionModel.maxValue}";
                }
              }
              return null;
            },
          ),
        ),
        CustomButton(
          heightPercent: 0.1,
          widthPercent: 0.1,
          action: () {
            setState(() {
              if (widget.questionModel.type.type == QuestionType.INT) {
                _value += 1;
              } else if (widget.questionModel.type.type == QuestionType.FLT) {
                _value += 0.1;
              }
              textEditingControllerNumber.text = _value.toStringAsFixed(1);
            });
          },
          textButton: "+",
          height: 57,
          width: 56,
        )
      ],
    ));
  }

  Widget answerTextFiel(BuildContext context, Size size) {
    return SizedBox(
      height: size.height * 0.1,
      width: size.width * 0.95,
      child: TextFormField(
        controller: textEditingController,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          labelText: 'Respuesta',
        ),
        onChanged: (value) {
          _textAnswer = value;
        },
        validator: (value) {
          if (value!.isEmpty) {
            return 'Por favor ingrese una respuesta';
          }
          return null;
        },
      ),
    );
  }
}
