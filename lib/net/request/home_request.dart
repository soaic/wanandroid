import 'dart:core';

import 'package:wanandroid/common/common.dart';
import 'package:wanandroid/model/article_entity.dart';
import 'package:wanandroid/model/banner_entity.dart';
import 'package:wanandroid/net/apis.dart';
import 'package:wanandroid/net/utils/http_utils.dart';

class HomeRequest {

  static Future<List<BannerEntity>> getBanner() async {
    BaseResp<List> baseResp = await HttpUtils().request<List>(Apis.BANNER);

    if (baseResp.code != Constant.status_success) {
      return Future.error(baseResp.msg);
    }
    List<BannerEntity> listBanner;
    if (baseResp.data != null) {
      listBanner = baseResp.data.map((e) {
        return BannerEntity.fromJson(e);
      }).toList();
    }

    return listBanner;
  }

  static Future<List<ArticleEntity>> getArticleList({int page: 0}) async{
    BaseResp<Map<String, dynamic>> baseResp = await HttpUtils()
        .request(Apis.getPath(path:  Apis.HOME_ARTICLE, page: page));

    List<ArticleEntity> listArticle;
    if (baseResp.data != null) {
      ComData comData = ComData.fromJson(baseResp.data);
      listArticle = comData.datas.map((e) {
        return ArticleEntity.fromJson(e);
      }).toList();
    }

    return listArticle;
  }

}
