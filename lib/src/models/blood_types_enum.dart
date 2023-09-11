enum BloodType {
  AP,
  BP,
  OP,
  ABP,
  AL,
  BL,
  OL,
  ABL;

  static BloodType fromString(String txt) {
    String str = txt.toUpperCase();
    BloodType bloodType;
    switch (str) {
      case "AP":
        bloodType = BloodType.AP;
        break;
      case "BP":
        bloodType = BloodType.BP;
        break;
      case "OP":
        bloodType = BloodType.OP;
        break;
      case "ABP":
        bloodType = BloodType.ABP;
        break;
      case "AL":
        bloodType = BloodType.AL;
        break;
      case "BL":
        bloodType = BloodType.BL;
        break;
      case "OL":
        bloodType = BloodType.OL;
        break;
      case "ABL":
        bloodType = BloodType.ABL;
        break;
      default:
        bloodType = BloodType.OP;
        break;
    }
    return bloodType;
  }
}
