

enum QuestionType {
  FLT(type: 'flt'),
  INT(type: 'int'),
  TXT(type: 'txt'),
  CHOOSEM(type: 'chooseM'),
  CHOOSEU(type: 'chooseU'),
  OTHER(type: 'OTHER');

  final String type;

  const QuestionType({required this.type});

  static QuestionType format(String type) {
    type = type.toLowerCase();
    QuestionType questionType;
    if (type == 'flt') {
      questionType = QuestionType.FLT;
    } else if (type == 'int') {
      questionType = QuestionType.INT;
    } else if (type == 'txt') {
      questionType = QuestionType.TXT;
    } else if (type == 'choosem') {
      questionType = QuestionType.CHOOSEM;
    } else if (type == 'chooseu') {
      questionType = QuestionType.CHOOSEU;
    } else {
      questionType = QuestionType.OTHER;
    }

    return questionType;
  }

  @override
  String toString() => type;
}
