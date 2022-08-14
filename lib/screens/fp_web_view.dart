import 'dart:developer';
import 'dart:io';
import 'package:boost_msme_app_builder/res/fp_constants.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class FPWebView extends StatefulWidget {
  const FPWebView({Key? key}) : super(key: key);

  // final String fpTag;
  // final String businessName;

  @override
  State<FPWebView> createState() => _FPWebViewState();
}

class _FPWebViewState extends State<FPWebView> {
  bool isLoading = true;
  final _key = UniqueKey();

  Future<void> _launch(Uri url) async {
    await canLaunchUrl(url)
        ? await launchUrl(url)
        : log('could_not_launch_this_app'.trim());
  }

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    double topPadding = MediaQuery.of(context).size.height * 0.04;
    return Stack(
      children: <Widget>[
        Container(
            padding: EdgeInsets.fromLTRB(0, topPadding, 0, 0),
            decoration: const BoxDecoration(color: Colors.black),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: WebView(
              key: _key,
              initialUrl: FPConstants.fpRootAliasUri,
              javascriptMode: JavascriptMode.unrestricted,
              onPageFinished: (finish) {
                setState(() {
                  isLoading = false;
                });
              },
              //TODO: Please comment-out Line 56 to 74 before publishing app.
              onWebResourceError: (WebResourceError webviewerrr) {
                final snackBar = SnackBar(
                  content: Text(
                      'Failed to load a static asset. Please contact us. [E13] U - ' +
                          webviewerrr.failingUrl! +
                          ' D - ' +
                          webviewerrr.domain! +
                          ' E - ' +
                          webviewerrr.description),
                  action: SnackBarAction(
                    label: 'OK',
                    textColor: FPConstants.fpLogoForegroundColor,
                    onPressed: () {
                      // Some code to undo the change.
                    },
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              navigationDelegate: (NavigationRequest request) {
                if (request.url.contains("mailto:")) {
                  _launch(Uri.parse(request.url));
                  return NavigationDecision.prevent;
                } else if (request.url.contains("tel:")) {
                  _launch(Uri.parse(request.url));
                  return NavigationDecision.prevent;
                }

                if (!request.url.toUpperCase().startsWith('HTTPS')) {
                  final snackBar = SnackBar(
                    content: const Text(
                        'There is an error. Please contact us. [E12]'),
                    action: SnackBarAction(
                      label: 'OK',
                      textColor: FPConstants.fpLogoForegroundColor,
                      onPressed: () {
                        // Some code to undo the change.
                      },
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);

                  return NavigationDecision.prevent;
                }

                return NavigationDecision.navigate;
              },
            )),
        isLoading
            ? const Align(
                alignment: Alignment.bottomCenter,
                child: LinearProgressIndicator(),
              )
            : Stack(),
      ],
    );
  }
}
