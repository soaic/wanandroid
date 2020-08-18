import 'package:wanandroid/common/common.dart';
import 'package:wanandroid/model/score_entity.dart';
import 'package:wanandroid/model/score_info_entity.dart';
import 'package:wanandroid/model/user_entity.dart';
import 'package:wanandroid/net/apis.dart';
import 'package:wanandroid/net/utils/http_utils.dart';
import 'package:wanandroid/utils/json_util.dart';
import 'package:wanandroid/utils/sp_util.dart';

class UserRequest {
  static Future<UserEntity> login(String userName, String password) async {
    BaseResp<Map<String, dynamic>> baseResp = await HttpUtils().request(
        Apis.USER_LOGIN,
        method: Method.POST,
        queryParams: {"username": userName, "password": password});

    if (baseResp.code != Constant.status_success) {
      return Future.error(baseResp.msg);
    }

    UserEntity userEntity;
    if (baseResp.data != null) {
      userEntity = UserEntity.fromJson(baseResp.data);
    }

    SPUtil.putString("cookies", baseResp.cookies.toString());
    SPUtil.putString("userInfo", JsonUtil.encode(userEntity));

    return userEntity;
  }

  static Future<UserEntity> register(String userName, String password) async {
    BaseResp<Map<String, dynamic>> baseResp = await HttpUtils()
        .request(Apis.USER_REGISTER, method: Method.POST, queryParams: {
      "username": userName,
      "password": password,
      "repassword": password
    });

    if (baseResp.code != Constant.status_success) {
      return Future.error(baseResp.msg);
    }

    UserEntity userEntity;
    if (baseResp.data != null) {
      userEntity = UserEntity.fromJson(baseResp.data);
    }
    return userEntity;
  }

  static Future<List<ScoreEntity>> getScoreList(int page) async {
    String url =
        Apis.getPath(path: Apis.COIN_LIST, page: page, resType: "json");
    BaseResp<Map<String, dynamic>> baseResp =
        await HttpUtils().request(url, method: Method.GET);

    if (baseResp.code != Constant.status_success) {
      return Future.error(baseResp.msg);
    }

    List<ScoreEntity> scoreEntitys;
    if (baseResp.data != null) {
      ComData comData = ComData.fromJson(baseResp.data);
      scoreEntitys = comData.datas.map((e) {
        return ScoreEntity.fromJson(e);
      }).toList();
    }

    return scoreEntitys;
  }

  static Future<ScoreInfoEntity> getScoreInfo() async {
    BaseResp<Map<String, dynamic>> baseResp = await HttpUtils()
        .request(Apis.getPath(path: Apis.COIN_USER_INFO), method: Method.GET);

    if (baseResp.code != Constant.status_success) {
      return Future.error(baseResp.msg);
    }

    ScoreInfoEntity scoreInfoEntity;
    if (baseResp.data != null) {
      scoreInfoEntity = ScoreInfoEntity.fromJson(baseResp.data);
    }
    return scoreInfoEntity;
  }

  static Future<bool> logout() async {
    BaseResp<Map<String, dynamic>> baseResp = await HttpUtils()
        .request(Apis.getPath(path: Apis.USER_LOGOUT), method: Method.GET);

    if (baseResp.code != Constant.status_success) {
      return Future.error(baseResp.msg);
    }

    return true;
  }
}
