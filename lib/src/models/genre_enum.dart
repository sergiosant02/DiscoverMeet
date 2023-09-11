// ignore_for_file: constant_identifier_names

enum Genre {
  MALE,
  FEMALE;

  static String getTranslate(Genre genre) {
    String res = "";
    switch (genre) {
      case Genre.FEMALE:
        res = "Mujer";
        break;
      case Genre.MALE:
        res = "Hombre";
        break;
      default:
        res = "Hombre";
        break;
    }
    return res;
  }

  static Genre fromString(String str) {
    Genre genre;
    if (str.toUpperCase() == "MALE") {
      genre = Genre.MALE;
    } else {
      genre = Genre.FEMALE;
    }
    return genre;
  }

  static String getString(Genre genre) {
    String res = "";
    switch (genre) {
      case Genre.FEMALE:
        res = "FEMALE";
        break;
      case Genre.MALE:
        res = "MALE";
        break;
      default:
        res = "MALE";
        break;
    }
    return res;
  }
}
