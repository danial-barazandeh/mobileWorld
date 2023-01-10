import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:jmob/Pages/PhoneModelView/PhoneModelViewController.dart';
import 'package:jmob/Services/MyColors.dart';
import 'package:jmob/Services/MyStrings.dart';
import 'package:jmob/Widget/BottomNavigation/ButtomNavigation.dart';
import 'package:jmob/Widget/Drawer/MyDrawerController.dart';
import 'package:jmob/Widget/Drawer/MyPerfectDrawer.dart';
import 'package:jmob/Widget/BrandWidget.dart';
import 'package:jmob/Widget/Slider/MainSlider.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:woocommerce/models/product_category.dart';
import 'package:woocommerce/models/product_tag.dart';
import 'VendorPageController.dart';

class VendorPage extends GetView<VendorPageController> {
  VendorPageController vendorPageController = Get.find<VendorPageController>();

  MyColors myColors = Get.find<MyColors>();
  MyStrings myStrings = Get.find<MyStrings>();
  final myPerfectDrawer = Get.find<MyPerfectDrawer>();
  final myDrawerController = Get.find<MyDrawerController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: myColors.background,
        body: Obx(
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
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                SizedBox(
                  height: myDrawerController.isDrawerOpen.value ? 0 : 30,
                ),
                Stack(
                  children: [
                    Obx(() {
                        return Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          alignment: Alignment.topCenter,
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                    bottom: Radius.circular(16),
                                    top: Radius.circular(myDrawerController.isDrawerOpen.value ? 16 : 0)),
                                child: Image.network(
                                  vendorPageController.vendor.value.image,
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height * 0.2,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height * 0.15, left: 16, right: 16),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.all(Radius.circular(16)),
                                  child: Container(
                                    color: Colors.white,
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height * 0.6,
                                    alignment: Alignment.topCenter,
                                    child: Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              vendorPageController.vendor.value.name,
                                            style: TextStyle(fontWeight: FontWeight.w900,fontSize: 24),
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context).size.height*0.1,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Icon(Icons.phone),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(myStrings.phone +
                                                  " : " +
                                                  vendorPageController.vendor.value.phone)
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Icon(Icons.add_location_rounded),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(myStrings.city +
                                                  " : " +
                                                  vendorPageController.vendor.value.city)
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Icon(Icons.add_business),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(myStrings.address +
                                                  " : " +
                                                  vendorPageController.vendor.value.address)
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text(myStrings.storeRating),
                                              IgnorePointer(
                                                child: RatingBar.builder(
                                                  initialRating: double.parse(
                                                      "4.0"),
                                                  minRating: 5,
                                                  direction: Axis.horizontal,
                                                  allowHalfRating: true,
                                                  itemCount: 5,
                                                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                                  itemBuilder: (context, _) => Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                  ),
                                                  onRatingUpdate: (rating) {
                                                    print(rating);
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            width: MediaQuery.of(context).size.width,
                                            child: Text(
                                              myStrings.rateCount +
                                                  " : " +
                                                  "4",
                                              textAlign: TextAlign.right,
                                            ),
                                          ),

                                          SizedBox(
                                            height: 10,
                                          ),

                                          if(true)


                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Card(
                                              color: myColors.coll,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(16),
                                              ),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Container(
                                                    width: MediaQuery.of(context).size.width,
                                                    child: Text(
                                                      myStrings.featuredShop,
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        color: Colors.white
                                                      ),
                                                    ),
                                                  ),
                                                  IgnorePointer(
                                                    child: Checkbox(
                                                      checkColor: Colors.white,
                                                      activeColor: myColors.coll,
                                                      onChanged: (value) {
                                                      }, value: true,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                    }),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        myDrawerController.isDrawerOpen.value
                            ? IconButton(
                                icon: Icon(Icons.arrow_back, color: Colors.white),
                                onPressed: () => myDrawerController.CloseDrawer(),
                              )
                            : IconButton(
                                icon: Icon(Icons.menu, color: Colors.white),
                                onPressed: () => myDrawerController.OpenDrawer(context),
                              ),
                        Text(
                          myStrings.shop,
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
