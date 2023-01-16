import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:jmob/Pages/PartList/PartListController.dart';
import 'package:jmob/Pages/SearchPage/SearchPage.dart';
import 'package:jmob/Pages/SearchPage/SearchPageBinding.dart';
import 'package:jmob/Services/MyColors.dart';
import 'package:jmob/Services/MyStrings.dart';
import 'package:jmob/Widget/BottomNavigation/ButtomNavigation.dart';
import 'package:jmob/Widget/Drawer/MyDrawerController.dart';
import 'package:jmob/Widget/Drawer/MyPerfectDrawer.dart';
import 'package:jmob/Widget/BrandWidget.dart';
import 'package:jmob/Widget/Slider/MainSlider.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'AboutController.dart';

class About extends GetView<AboutController> {
  AboutController aboutController = Get.find<AboutController>();
  final myPerfectDrawer = Get.find<MyPerfectDrawer>();
  final myDrawerController = Get.find<MyDrawerController>();

  @override
  Widget build(BuildContext context) {
    MyColors myColors = new MyColors();
    MyStrings myStrings = Get.find<MyStrings>();

    return Scaffold(
        bottomNavigationBar: ButtomNavigation(),
        backgroundColor: myColors.background,
        body: Stack(
          children: [
            myPerfectDrawer,
            Obx(
              () => AnimatedContainer(
                transform: Matrix4.translationValues(
                    myDrawerController.xOffset.value, myDrawerController.yOffset.value * 1.5, 0)
                  ..scale(myDrawerController.scaleFactor.value),
                duration: Duration(milliseconds: 250),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    color: myColors.backgroundColor,
                    borderRadius: BorderRadius.circular(myDrawerController.isDrawerOpen.value ? 30 : 0)),
                child: Theme(
                    data: Theme.of(context).copyWith(accentColor: Colors.yellow),
                    child: Column(
                      children: [
                        SizedBox(
                          height: myDrawerController.isDrawerOpen.value ? 10 : 30,
                        ),
                        Stack(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    myDrawerController.isDrawerOpen.value
                                        ? Container(
                                      width: MediaQuery.of(context).size.width,
                                      alignment: Alignment.centerRight,
                                      child: IconButton(
                                        icon: Icon(Icons.arrow_forward, color: myColors.textColor),
                                        onPressed: () => myDrawerController.CloseDrawer(),
                                      ),
                                    )
                                        : IconButton(
                                      icon: Icon(Icons.menu, color: myColors.textColor),
                                      onPressed: () => myDrawerController.OpenDrawer(context),
                                    ),
                                    !myDrawerController.isDrawerOpen.value
                                        ? Text(
                                      myStrings.about,
                                      style: TextStyle(color: myColors.textColor),
                                    ) : SizedBox(),
                                  ],
                                ),
                                !myDrawerController.isDrawerOpen.value
                                    ? Expanded(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: IconButton(
                                      icon: Icon(Icons.search, color: myColors.textColor),
                                      onPressed: () => Get.to(() => SearchPage(), binding: SearchPageBinding()),
                                    ),
                                  ),
                                ) : SizedBox(),
                              ],
                            ),
                          ],
                        ),
                        Expanded(
                          child: WebView(
                            initialUrl: 'https://jmob.ir/about-us/',
                            javascriptMode: JavascriptMode.unrestricted,
                            onWebViewCreated: (WebViewController webViewController) {
                              // _controller.complete(webViewController);
                            },
                            onProgress: (int progress) {
                              print('WebView is loading (progress : $progress%)');
                            },
                            javascriptChannels: <JavascriptChannel>{
                              // _toasterJavascriptChannel(context),
                            },
                            navigationDelegate: (NavigationRequest request) {
                              if (request.url.startsWith('https://www.youtube.com/')) {
                                print('blocking navigation to $request}');
                                return NavigationDecision.prevent;
                              }
                              print('allowing navigation to $request');
                              return NavigationDecision.navigate;
                            },
                            onPageStarted: (String url) {
                              print('Page started loading: $url');
                            },
                            onPageFinished: (String url) {
                              print('Page finished loading: $url');
                            },
                            gestureNavigationEnabled: true,
                            // backgroundColor: const Color(0x00000000),
                          ),
                        )
                      ],
                    )),
              ),
            ),
            IgnorePointer(
              child: Obx(() => AnimatedContainer(
                    transform: Matrix4.translationValues(
                        myDrawerController.xOffset.value, myDrawerController.yOffset.value * 1.5, 0)
                      ..scale(myDrawerController.scaleFactor.value),
                    duration: Duration(milliseconds: 250),
                    decoration: BoxDecoration(
                        // color: myDrawerController.backgroundColor.value,
                        borderRadius: BorderRadius.circular(myDrawerController.isDrawerOpen.value ? 0 : 0)),
                  )),
            )
          ],
        ));
  }
}
