import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyWebView extends StatefulWidget {
  final String selectedUrl;
  final String title;

  const MyWebView({Key? key, required this.selectedUrl, required this.title})
      : super(key: key);

  @override
  State<MyWebView> createState() => _MyWebViewState();
}

class _MyWebViewState extends State<MyWebView> {
  late final WebViewController _controller;
  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return const Dialog(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SpinKitCircle(
                          color: Colors.blue,
                          size: 50.0,
                        ),
                        SizedBox(height: 16.0),
                        Text('Sayfa yükleniyor...'),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          onPageFinished: (String url) {
            Navigator.of(context, rootNavigator: true).pop();
          },
          onWebResourceError: (WebResourceError error) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return const Dialog(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('An error occured. please try again later.'),
                  ),
                );
              },
            );
          },
        ),
      )
      ..loadRequest(
        Uri.parse(widget.selectedUrl),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: [
            IconButton(onPressed: () {
              FlutterShare.share(
                  title: widget.title,
                linkUrl: widget.selectedUrl
              );
            }, icon: const Icon(Icons.share_outlined)),
          ]),
      body: WebViewWidget(
        controller: _controller,
      ),
    );
  }
}
