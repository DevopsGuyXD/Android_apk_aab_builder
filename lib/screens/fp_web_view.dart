import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:boost_msme_app_builder/res/fp_constants.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FPWebView extends StatefulWidget {
  const FPWebView({Key? key}) : super(key: key);

  // final String fpTag;
  // final String businessName;

  @override
  State<FPWebView> createState() => _FPWebViewState();
}

class _FPWebViewState extends State<FPWebView> {
  bool _isLoading = true;
  final _key = UniqueKey();
  late WebViewController _webViewController;

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

  Future loadHttpsUrl(String httpsUrl) async {
    await _webViewController.loadUrl(httpsUrl);
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
              onWebViewCreated: (WebViewController webViewController) {
                _webViewController = webViewController;
              },
              onPageFinished: (url) {
                setState(() {
                  _isLoading = false;
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
                String scheme = FPConstants.httpScheme;
                String currentUrl = request.url;

                if (currentUrl.contains("mailto:")) {
                  _launch(Uri.parse(currentUrl));
                  return NavigationDecision.prevent;
                } else if (currentUrl.contains("tel:")) {
                  _launch(Uri.parse(currentUrl));
                  return NavigationDecision.prevent;
                }

                //Replacing just the http part with https and not hampering rest of the url
                if (!currentUrl
                        .toUpperCase()
                        .startsWith(FPConstants.httpScheme) &&
                    !currentUrl
                        .toUpperCase()
                        .startsWith(FPConstants.httpsScheme)) {
                  currentUrl =
                      FPConstants.httpScheme.toLowerCase() + currentUrl;
                }

                if (currentUrl.toUpperCase().startsWith(scheme)) {
                  if (!FPConstants.fpStaticContentRegex
                      .hasMatch(currentUrl.toLowerCase())) {
                    currentUrl = currentUrl.replaceRange(0, scheme.length,
                        FPConstants.httpsScheme.toLowerCase());
                    setState(() async {
                      await loadHttpsUrl(currentUrl);
                    });
                  } else {
                    return NavigationDecision.prevent;
                  }
                }

                if (!currentUrl
                    .toUpperCase()
                    .startsWith(FPConstants.httpsScheme)) {
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
        _isLoading
            ? const Align(
                alignment: Alignment.bottomCenter,
                child: LinearProgressIndicator(),
              )
            : Stack(),
      ],
    );
  }
}