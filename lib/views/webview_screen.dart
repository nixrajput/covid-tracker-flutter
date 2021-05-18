import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  final String url;

  const WebViewScreen({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  var _progress = 0.0;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    final bodyHeight = MediaQuery.of(context).size.height;
    final bodyWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: _customBodyArea(bodyHeight, bodyWidth),
      ),
    );
  }

  Column _customBodyArea(double height, double width) => Column(
        children: [
          _progress < 1.0
              ? LinearProgressIndicator(
                  value: _progress,
                )
              : SizedBox(),
          Builder(
            builder: (ctx) {
              return Expanded(
                child: WebView(
                  javascriptMode: JavascriptMode.unrestricted,
                  initialUrl: widget.url,
                  onWebViewCreated: (WebViewController webViewController) {
                    _controller.complete(webViewController);
                  },
                  onProgress: (progress) {
                    setState(() {
                      _progress = progress / 100.0;
                    });
                  },
                  onPageStarted: (String url) {
                    print('Loading page...');
                  },
                  onPageFinished: (String url) {
                    print('Finished loading.');
                  },
                  gestureNavigationEnabled: true,
                ),
              );
            },
          ),
        ],
      );
}
