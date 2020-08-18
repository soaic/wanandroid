import 'dart:convert' as convert;

class JsonUtil {

  static String encode(Object obj) {
    return convert.jsonEncode(obj);
  }

  static dynamic decode(String jsonStr) {
    return convert.jsonDecode(jsonStr);
  }

}