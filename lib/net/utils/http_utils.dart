import 'dart:io';

import 'package:dio/dio.dart';
import 'package:wanandroid/net/apis.dart';
import 'dart:convert';

import 'package:wanandroid/utils/log_util.dart';
import 'package:wanandroid/utils/sp_util.dart';

class HttpUtils {
  factory HttpUtils() => _getInstance();
  static HttpUtils _instance;

  static const String _codeKey = "errorCode";
  static const String _msgKey = "errorMsg";
  static const String _dataKey = "data";
  static Dio _dio;

  HttpUtils._internal() {
    _dio = new Dio();
  }

  static HttpUtils _getInstance() {
    if (_instance == null) {
      _instance = new HttpUtils._internal();
    }
    return _instance;
  }

  Future<BaseResp<T>> request<T>(String url,
      {data,
      String method: Method.GET,
      Map<String, dynamic> queryParams,
      Map<String, dynamic> headers,
      String baseUrl: Apis.BASE_URL}) async {

    int _code = 0;
    String _msg = "";
    T _data;
    var _cookies = "";
    Response response;

    try {
      String cookies = SPUtil.get("cookies", "");
      if (cookies.isNotEmpty) {
        if (headers == null) {
          headers = new Map<String, dynamic>();
        }
        headers['Cookie'] = cookies;
      }

      Options options = Options(method: method, headers: headers);
      _dio.options.baseUrl = baseUrl;

      response = await _dio.request(url,
          data: data, queryParameters: queryParams, options: options);

      LogUtil.v("request url: ${response.request.uri}");

      response.headers.map.forEach((key, value) {
        if ("set-cookie" == key) {
          _cookies = value.toString();
        }
      });

      if (response.statusCode == HttpStatus.ok) {
        if (response.data is Map) {
          _data = response.data[_dataKey];
          _code = response.data[_codeKey];
          _msg = response.data[_msgKey];
        } else {
          Map<String, dynamic> dataMap = _decodeData(response);
          _data = dataMap[_dataKey];
          _code = dataMap[_codeKey];
          _msg = dataMap[_msgKey];
        }
      } else {
        _code = 9999;
        _msg = response.statusMessage;
      }
    } catch (e) {
      _code = 9999;
      _msg = e.toString();
    }

    return new BaseResp(_code, _msg, _data, _cookies);
  }

}

Map<String, dynamic> _decodeData(Response response) {
  if (response == null ||
      response.data == null ||
      response.data.toString().isEmpty) {
    return new Map();
  }
  return json.decode(response.data.toString());
}

class Method {
  static const String GET = "GET";
  static const String POST = "POST";
  static const String PUT = "PUT";
}

class BaseResp<T> {
  int code;
  String msg;
  T data;
  String cookies;

  BaseResp(this.code, this.msg, this.data, this.cookies);

  @override
  String toString() {
    StringBuffer sb = new StringBuffer('{');
    sb.write(",\"code\":$code");
    sb.write(",\"msg\":\"$msg\"");
    sb.write(",\"data\":\"$data\"");
    sb.write(",\"cookies\":\"$cookies\"");
    sb.write('}');
    return sb.toString();
  }
}

class ComData {
  int size;
  List datas;

  ComData.fromJson(Map<String, dynamic> json)
      : size = json['size'],
        datas = json['datas'];
}
