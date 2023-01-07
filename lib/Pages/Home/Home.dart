import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:jmob/Pages/PartList/PartListController.dart';
import 'package:jmob/Pages/PostView/PostView.dart';
import 'package:jmob/Pages/PostView/PostViewController.dart';
import 'package:jmob/Pages/SearchPage/SearchPage.dart';
import 'package:jmob/Pages/SearchPage/SearchPageBinding.dart';
import 'package:jmob/Services/MyColors.dart';
import 'package:jmob/Services/MyStrings.dart';
import 'package:jmob/Widget/BottomNavigation/ButtomNavigation.dart';
import 'package:jmob/Widget/BrandWidgetPlaceHolder.dart';
import 'package:jmob/Widget/Drawer/MyDrawerController.dart';
import 'package:jmob/Widget/Drawer/MyPerfectDrawer.dart';
import 'package:jmob/Widget/BrandWidget.dart';
import 'package:jmob/Widget/PostWidget.dart';
import 'package:jmob/Widget/Slider/MainSlider.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:slide_countdown/slide_countdown.dart';

import 'HomeController.dart';

class Home extends GetView<HomeController> {
  HomeController homeController = Get.find<HomeController>();
  final myPerfectDrawer = Get.find<MyPerfectDrawer>();
  final myDrawerController = Get.find<MyDrawerController>();

  List<BoxShadow> shadowList = [BoxShadow(color: Colors.grey[300]!, blurRadius: 30, offset: Offset(0, 10))];

  @override
  Widget build(BuildContext context) {
    MyColors myColors = new MyColors();
    MyStrings myStrings = Get.find<MyStrings>();

    return Scaffold(
        backgroundColor: Colors.transparent,
        bottomNavigationBar: ButtomNavigation(),
        body: Stack(
          alignment: Alignment.topRight,
          children: [
            myPerfectDrawer,
            Obx(
              () => AnimatedContainer(
                transform: Matrix4.translationValues(myDrawerController.xOffset.value, myDrawerController.yOffset.value * 1.5, 0)
                  ..scale(myDrawerController.scaleFactor.value),
                duration: Duration(milliseconds: 250),
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: myColors.textColor.withOpacity(0.15),
                    spreadRadius: 7,
                    blurRadius: 10,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ], color: myColors.backgroundColor, borderRadius: BorderRadius.circular(myDrawerController.isDrawerOpen.value ? 30 : 0)),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Theme(
                    data: Theme.of(context).copyWith(accentColor: Colors.yellow),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                                        myStrings.home,
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
                          SizedBox(height: 4),
                          MainSlider(),
                          SizedBox(height: 12),
                          Obx(() {
                            if (homeController.isLoading.value)
                              return Container(
                                height: MediaQuery.of(context).size.height * 0.3,
                                width: MediaQuery.of(context).size.width,
                                color: myColors.primary,
                                child: GridView.builder(
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                    ),
                                    padding: EdgeInsets.only(right: 4, left: 4),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 8,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return Container(padding: EdgeInsets.all(6), child: BrandWidgetPlaceHolder());
                                    }),
                              );
                            else {
                              return Container(
                                height: MediaQuery.of(context).size.height * 0.3,
                                width: MediaQuery.of(context).size.width,
                                color: myColors.primary,
                                padding: EdgeInsets.only(top: 16, bottom: 16),
                                child: GridView.builder(
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                    ),
                                    padding: EdgeInsets.only(right: 4, left: 4),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: homeController.brandList.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return Container(
                                          child: GestureDetector(
                                        onTap: () {
                                          homeController.selectBrand(homeController.brandList.value[index]);
                                        },
                                        child: BrandWidget(homeController.brandList.value[index]),
                                      ));
                                    }),
                              );
                            }
                          }),
                          Container(
                              width: MediaQuery.of(context).size.width,
                              alignment: Alignment.topLeft,
                              child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  myStrings.blogs,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(color: myColors.textColor.withAlpha(100)),
                                ),
                              )),
                          Obx(() {
                            if (!homeController.isLoading.value)
                              return Container(
                                height: MediaQuery.of(context).size.height * 0.18,
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.only(right: 8, left: 8),
                                child: ListView.builder(
                                    itemCount: controller.postList.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return Container(
                                          child: GestureDetector(
                                        onTap: () {
                                          try {
                                            PostViewController postViewController = Get.find<PostViewController>();
                                            postViewController.selectedPost.value = controller.postList[index];
                                            Get.to(PostView());
                                          } catch (e) {
                                            Get.put(PostViewController());
                                            PostViewController postViewController = Get.find<PostViewController>();
                                            postViewController.selectedPost.value = controller.postList[index];
                                            Get.to(PostView());
                                          }
                                        },
                                        child: PostWidget(homeController.postList.value[index]),
                                      ));
                                    }),
                              );
                            else
                              return Container(
                                height: MediaQuery.of(context).size.height * 0.18,
                                width: MediaQuery.of(context).size.width,
                                child: ListView.builder(
                                    itemCount: 3,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return Container(
                                          padding: EdgeInsets.all(8),
                                          child: SkeletonAnimation(
                                            shimmerColor: Colors.grey.shade300,
                                            borderRadius: BorderRadius.circular(20),
                                            shimmerDuration: 2000,
                                            child: Container(
                                              height: MediaQuery.of(context).size.height * 0.18,
                                              width: MediaQuery.of(context).size.width * 0.4,
                                              decoration: BoxDecoration(
                                                color: Colors.grey[100],
                                                borderRadius: BorderRadius.circular(20),
                                                // boxShadow: shadowList,
                                              ),
                                            ),
                                          ));
                                    }),
                              );
                          }),
                          IgnorePointer(
                            child: Obx(() => AnimatedContainer(
                                  transform: Matrix4.translationValues(myDrawerController.xOffset.value, myDrawerController.yOffset.value * 1.5, 0)
                                    ..scale(myDrawerController.scaleFactor.value),
                                  duration: Duration(milliseconds: 250),
                                  decoration: BoxDecoration(
                                      // color: myDrawerController.backgroundColor.value,
                                      borderRadius: BorderRadius.circular(myDrawerController.isDrawerOpen.value ? 0 : 0)),
                                )),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
