import 'dart:async';

import 'package:boost_msme_app_builder/res/boost_assets.dart';
import 'package:boost_msme_app_builder/res/fp_constants.dart';
import 'package:boost_msme_app_builder/screens/fp_web_view.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: (1)),
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: FPConstants.fpLogoBackgroundColor,
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                width: MediaQuery.of(context).size.width,
                child: Image.network(FPConstants.fpLogoUri),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width,
                child: Lottie.asset(
                  BoostAssets.splash_loader,
                  controller: _controller,
                  fit: BoxFit.contain,
                  animate: true,
                  repeat: true,
                  delegates: LottieDelegates(
                    values: [
                      ValueDelegate.color(
                        const ['Shape Layer 4', 'Rectangle 1', 'Fill 1'],
                        value: FPConstants.fpLogoForegroundColor,
                      ),
                      ValueDelegate.color(
                        const ['Shape Layer 3', 'Rectangle 1', 'Fill 1'],
                        value: FPConstants.fpLogoForegroundColor,
                      ),
                      ValueDelegate.color(
                          const ['Shape Layer 2', 'Rectangle 1', 'Fill 1'],
                          value: FPConstants.fpLogoForegroundColor),
                      ValueDelegate.color(
                        const ['Shape Layer 1', 'Rectangle 1', 'Fill 1'],
                        value: FPConstants.fpLogoForegroundColor,
                      ),
                    ],
                  ),
                  onLoaded: (composition) {
                    _controller
                      ..duration = composition.duration
                      ..forward().whenComplete(
                          () => Timer(const Duration(seconds: 3), () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return const Scaffold(
                                        // appBar: AppBar(
                                        //   title: const Text('SnackBar Demo'),
                                        // ),
                                        body: FPWebView(),
                                      );
                                    },
                                  ),
                                );
                              }));
                  },
                ),
              )
            ]));
  }
}
