import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:jmob/Pages/Home/Home.dart';
import 'package:jmob/Pages/Home/HomeBinding.dart';
import 'package:jmob/Services/MyColors.dart';
import 'package:jmob/Services/MyStrings.dart';
import 'package:jmob/Widget/BottomNavigation/ButtomNavigation.dart';
import 'package:jmob/Widget/BrandWidget.dart';
import 'package:jmob/Widget/ProductWidget.dart';
import 'package:jmob/Widget/Slider/MainSlider.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:woocommerce/models/product_category.dart';
import 'package:woocommerce/models/product_tag.dart';

import '../../Model/Product.dart';
import '../../Widget/ProductWidgetMultilevel.dart';
import 'PartListController.dart';

class PartList extends GetView<PartListController> {
  PartListController partListController = Get.find<PartListController>();
  bool isListUsed = false;
  @override
  Widget build(BuildContext context) {
    MyColors myColors = new MyColors();
    MyStrings myStrings = Get.find<MyStrings>();

    return Scaffold(
        backgroundColor: myColors.background,
        bottomNavigationBar: ButtomNavigation(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 35),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: myColors.textColor),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Text(
                      partListController.selectedDevice.value.name ?? "",
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
            SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(myStrings.models,textAlign: TextAlign.center),
                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Flex(
                        direction: Axis.horizontal,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              partListController.selectedDevice.value.models.toString(),
                              overflow: TextOverflow.fade,
                              maxLines: 4,
                              softWrap: true,
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.15,
                      width: MediaQuery.of(context).size.height * 0.15,
                      child: CachedNetworkImage(
                        imageUrl: partListController.selectedDevice.value.image.toString(),
                        progressIndicatorBuilder: (context, url, downloadProgress) => Container(
                            child: SkeletonAnimation(
                          shimmerColor: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(20),
                          shimmerDuration: 2000,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(20),
                              // boxShadow: shadowList,
                            ),
                          ),
                        )),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 8,
            ),

            Obx(() {
              return Expanded(
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                          padding: EdgeInsets.all(0),
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.productCategoryList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Container(
                                child: Obx(
                                  () => GestureDetector(
                                    onTap: () {
                                      controller.selectTab(index);
                                      // print(controller.productGroupBy(controller.activatedTab.value).values.toList().first);
                                    },
                                    child: Container(
                                        height: MediaQuery.of(context).size.height,
                                        width: MediaQuery.of(context).size.width * 0.3,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: controller.activatedTab.value.isEqual(index) ? Colors.white : myColors.background,
                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.3),
                                              spreadRadius: 1,
                                              blurRadius: 4,
                                              offset: Offset(0, 1), // changes position of shadow
                                            ),
                                          ],
                                          // boxShadow: shadowList,
                                        ),
                                        child: Text(controller.productCategoryList[index].name)),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),

                    Obx(
                      ()=> Expanded(
                        child: Container(
                          color:Colors.white,
                          child: Theme(
                            data: Theme.of(context).copyWith(colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.white.withAlpha(0))),
                            child: ListView.builder(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.all(0),
                                  scrollDirection: Axis.vertical,
                                  itemCount: controller.productList.length,
                                  itemBuilder: (context, index) {

                                    try{
                                      var temp = controller.productGroupBy(controller.activatedTab.value).values.toList()[index];
                                      if(temp.length <= 1)
                                        return ProductWidget(controller.productList[index]);
                                      else
                                        return Container(
                                          margin: EdgeInsets.only(top:8,left: 8,right: 8),
                                            child: ProductWidgetMultilevel(controller.productGroupBy(controller.activatedTab.value).values.toList()[index])
                                        );
                                    }catch(e){
                                      return SizedBox();
                                    }

                                    // if(controller.listProductList[index].length <= 1)
                                    //   if(controller.listProductList[index].first.productCategoryId.toString() == controller.productCategoryList[controller.activatedTab.value].id.toString())
                                    //     return ProductWidget(controller.listProductList[index].first);
                                    //   else
                                    //     return SizedBox();
                                    // else
                                    //   return ProductWidgetMultilevel(controller.listProductList[index]);

                                  }),
                          ),
                        ),
                      ),
                    ),


                  ],
                ),
              );
            }),
          ],
        ));
  }
}
