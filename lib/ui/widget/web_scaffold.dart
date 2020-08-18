import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebScaffold extends StatefulWidget {
  final String title;
  final String url;
  final OnWebViewListener onWebViewListener;
  final String userAgent;

  const WebScaffold({
    Key key,
    this.title,
    this.url,
    this.onWebViewListener,
    this.userAgent
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new WebScaffoldState();
  }
}

class WebScaffoldState extends State<WebScaffold> {
  WebViewController _webViewController;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          widget.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        centerTitle: true,
      ),
      body: new WebView(
        userAgent: widget.userAgent,
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
        onWebResourceError: (error) {
          print(error);
        },
        debuggingEnabled: true,
        navigationDelegate: (navigation) {
          print("navigation.url=$navigation.url");
          // 阻止进入登录页面
          //return NavigationDecision.prevent;
          return NavigationDecision.navigate;
        },
        onWebViewCreated: (WebViewController webViewController) {
          _webViewController = webViewController;
          if (widget.onWebViewListener != null && widget.onWebViewListener.onWebViewCreated != null) {
            widget.onWebViewListener.onWebViewCreated(_webViewController);
          }
        },
        onPageStarted: (url) {
          if (widget.onWebViewListener != null && widget.onWebViewListener.onPageStarted != null) {
            widget.onWebViewListener.onPageStarted(_webViewController, url);
          }
        },
        onPageFinished: (url) {
          if (widget.onWebViewListener != null && widget.onWebViewListener.onPageFinished != null) {
            widget.onWebViewListener.onPageFinished(_webViewController, url);
          }
        }
      ),
    );
  }
}

typedef OnPageStarted = void Function(WebViewController webViewController, String url);
typedef OnPageFinished = void Function(WebViewController webViewController, String url);
typedef OnWebViewCreated = void Function(WebViewController webViewController);

class OnWebViewListener {
  final OnPageStarted onPageStarted;
  final OnPageFinished onPageFinished;
  final OnWebViewCreated onWebViewCreated;
  OnWebViewListener ({
    this.onPageStarted,
    this.onPageFinished,
    this.onWebViewCreated
  });
}