class Funcsions {
  static int namevalueindex(String name) {
    switch (name) {
      case "Boshsahifa":
        return 0;
      case "Mahsulotlar":
        return 1;
      case "Yangi buyurtmalar":
        return 2;
      case "Qabul qilingan":
        return 3;
      case "Bajarilgan buyurtmalar":
        return 4;
      case "Bekor qilingan":
        return 5;
      case "Profil":
        return 6;
      case "cChiqish":
        return 7;
    }
    return 0;
  }

  static String toProcessCost(String value) {
    if (value == '0') {
      return '0';
    }
    // ignore: unused_local_variable
    bool real = false;
    // ignore: unused_local_variable
    String valueRealPart = '';
    if (value.indexOf('.') > 0) {
      real = true;
      valueRealPart = value.substring(value.indexOf('.'), value.length);
      value = value.substring(0, value.indexOf('.'));
    }
    String count = '';
    if (value.length > 3) {
      int a = 0;
      for (int i = value.length; 0 < i; i--) {
        if (a % 3 == 0) {
          count = value.substring(i - 1, i) + ' ' + count;
        } else {
          count = value.substring(i - 1, i) + count;
        }
        a++;
      }
    } else {
      count = value;
    }

    return count;
  }
}
