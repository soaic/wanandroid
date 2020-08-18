import 'package:wanandroid/common/common.dart';
import 'package:wanandroid/model/article_entity.dart';
import 'package:wanandroid/model/wx_article_entity.dart';
import 'package:wanandroid/net/apis.dart';
import 'package:wanandroid/net/utils/http_utils.dart';

class ArticleRequest {

  static Future<List<WxArticleEntity>> getWxArticle() async{

    String url = Apis.getPath(path: Apis.WX_ARTICLE_CHAPTERS, resType: "json");
    BaseResp<List> baseResp = await HttpUtils()
        .request(url, method: Method.GET);

    if (baseResp.code != Constant.status_success) {
      return Future.error(baseResp.msg);
    }

    List<WxArticleEntity> articleEntities;
    if (baseResp.data != null) {
      articleEntities = baseResp.data.map((e) {
        return WxArticleEntity.fromJson(e);
      }).toList();
    }
    return articleEntities;

  }

  static Future<List<ArticleEntity>> getWxArticleList(int wxArticle, int page) async{

    String url = Apis.getPath(path: Apis.WX_ARTICLE_LIST + "/$wxArticle", page: page, resType: "json");
    BaseResp<Map<String,dynamic>> baseResp = await HttpUtils()
        .request(url, method: Method.GET);

    if (baseResp.code != Constant.status_success) {
      return Future.error(baseResp.msg);
    }

    List<ArticleEntity> articleEntities;
    if (baseResp.data != null) {
      ComData comData = ComData.fromJson(baseResp.data);
      articleEntities = comData.datas.map((e) {
        return ArticleEntity.fromJson(e);
      }).toList();
    }
    return articleEntities;
  }

}