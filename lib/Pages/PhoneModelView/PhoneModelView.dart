import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:jmob/Pages/Home/Home.dart';
import 'package:jmob/Pages/Home/HomeBinding.dart';
import 'package:jmob/Services/MyColors.dart';
import 'package:jmob/Services/MyStrings.dart';
import 'package:jmob/Widget/BottomNavigation/ButtomNavigation.dart';
import 'package:jmob/Widget/DeviceWidget.dart';
import 'package:jmob/Widget/BrandWidget.dart';
import 'package:jmob/Widget/Slider/MainSlider.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:woocommerce/models/product_category.dart';

import '../../Widget/BrandWidgetPlaceHolder.dart';
import 'PhoneModelViewController.dart';

class PhoneModelView extends GetView<PhoneModelViewController> {
  PhoneModelViewController phoneModelViewController = Get.find<PhoneModelViewController>();


  @override
  Widget build(BuildContext context) {
    MyColors myColors = new MyColors();
    MyStrings myStrings = new MyStrings();

    // phoneModelViewController.getWooProductChildCategory();


    return Scaffold(
        backgroundColor: myColors.background,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
              margin: EdgeInsets.only(top:35),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back,
                        color: myColors.textColor),
                    onPressed:() {
                      Get.back();
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right:16),
                    child: Text(
                      phoneModelViewController.selectedBrand.value.name??"",
                      style: TextStyle(color: myColors.textColor),
                    ),
                  ),
                  // Expanded(
                  //   child: Container(
                  //     alignment: Alignment(-1, 0),
                  //     child: IconButton(
                  //       icon: Icon(
                  //         Icons.search,
                  //         color: myColors.textColor,
                  //       ),
                  //       onPressed: () {
                  //         // Navigator.push(
                  //         //   context,
                  //         //   MaterialPageRoute(
                  //         //       builder: (context) => SearchPage()),
                  //         // );
                  //       },
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),

            SizedBox(height:4),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width*0.3,
                    alignment: Alignment.center,
                    child: Card(
                      elevation:0,
                        color: myColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(250),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(myStrings.choseYourPhone,style: TextStyle(color: Colors.white),),
                        ),
                    ),
                  ),
              ],
            ),

            SizedBox(height: 2,),
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Obx((){
                    if(phoneModelViewController.isLoading.value)
                      return GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          padding: EdgeInsets.only(right: 4, left: 4),
                          scrollDirection: Axis.vertical,
                          itemCount: 8,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Container(
                                padding: EdgeInsets.all(6),
                                child: BrandWidgetPlaceHolder());
                          });
                    else
                      return GridView.builder(
                          padding: EdgeInsets.all(0),
                          scrollDirection: Axis.vertical,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          itemCount: phoneModelViewController.deviceList.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: (){
                                  phoneModelViewController.selectDevice(phoneModelViewController.deviceList.value[index]);
                              },
                              child: DeviceWidget(phoneModelViewController.deviceList.value[index]),
                            );
                          }
                  );}
            ),
                ),
            )

          ],
        )
    );
  }
}
