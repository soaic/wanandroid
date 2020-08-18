class Apis {
  static const String BASE_URL = "https://www.wanandroid.com/";

  //https://www.wanandroid.com/
  static const String BANNER = "banner/json";
  static const String HOME_ARTICLE = "article/list";
  static const String USER_LOGIN = "user/login";
  static const String USER_REGISTER = "user/register";
  static const String COIN_LIST = "lg/coin/list";
  static const String COIN_USER_INFO = "lg/coin/userinfo";
  static const String USER_LOGOUT = "user/logout";

  static const String WX_ARTICLE_CHAPTERS = "wxarticle/chapters";
  static const String WX_ARTICLE_LIST = "wxarticle/list";


  static String getPath({String path : '', int page, String resType: 'json'}) {
    StringBuffer sb = new StringBuffer(path);
    if (page != null) {
      sb.write('/$page');
    }
    if (resType != null) {
      sb.write('/$resType');
    }
    return sb.toString();
  }
}