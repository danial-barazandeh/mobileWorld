import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
import 'OrdersViewController.dart';

class OrdersView extends GetView<OrdersViewController> {

  String getPrice(String data){
    var nf = new NumberFormat.currency(name: 'IRR',symbol: "").format(int.parse(data.toString()));
    return nf.toString();
  }

  GetPage onPageCalled(GetPage page) {
    print("salammmmmmmmmmm");
    print("Inahash: "+page.name);
    return page;
  }


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
                
                Text(myStrings.ordersList)
              ],
            ),
          ),
          SizedBox(height: 4),
          Obx(() {


            if(controller.isLoaded.value)
            return Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                    padding: EdgeInsets.all(0),
                    scrollDirection: Axis.vertical,
                    itemCount: controller.ordersList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.transparent),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          boxShadow: [
                            BoxShadow(
                              color: myColors.primary.withAlpha(50),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: Offset(0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        margin: EdgeInsets.only(left: 16, right: 16, bottom: 16,top: 8),
                        padding: EdgeInsets.all(8),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [


                                Row(
                                  children: [
                                    Text(myStrings.productName + ": "),
                                    Text(controller.ordersList[index].product.name),
                                  ],
                                ),


                                if(controller.ordersList[index].status=="waiting")
                                IconButton(
                                  alignment: Alignment.center,
                                  icon: Icon(Icons.cancel, color: Colors.red,size: 15,),
                                  onPressed: () {
                                    controller.deleteOrder(controller.ordersList[index]);
                                  },
                                ),
                              ],
                            ),

                            SizedBox(height: 8,),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(myStrings.price + ": ",style: TextStyle(fontSize: 13),),
                                    Text(getPrice(controller.ordersList[index].product.price),style: TextStyle(fontSize: 13),),
                                  ],
                                ),


                                Row(
                                  children: [
                                    Text(myStrings.salesPrice + ": ",style: TextStyle(fontSize: 13),),
                                    Text(getPrice(controller.ordersList[index].product.salePrice),style: TextStyle(fontSize: 13),),
                                  ],
                                )
                              ],
                            ),

                            SizedBox(height: 8,),



                            if(controller.ordersList[index].status.toString()=="waiting")
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.green,
                                border: Border.all(color: Colors.transparent),
                                borderRadius: BorderRadius.all(Radius.circular(8)),
                              ),
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height*0.04,
                              child: Text(myStrings.waiting,style: TextStyle(color: Colors.white),),
                              alignment: Alignment.center,
                            ),

                            if(controller.ordersList[index].status.toString()=="done")
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  border: Border.all(color: Colors.transparent),
                                  borderRadius: BorderRadius.all(Radius.circular(8)),
                                ),
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height*0.04,
                                child: Text(myStrings.done,style: TextStyle(color: Colors.white),),
                                alignment: Alignment.center,
                              ),


                            if(controller.ordersList[index].status.toString()=="canceled")
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  border: Border.all(color: Colors.transparent),
                                  borderRadius: BorderRadius.all(Radius.circular(8)),
                                ),
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height*0.04,
                                child: Text(myStrings.canceled,style: TextStyle(color: Colors.white),),
                                alignment: Alignment.center,
                              ),


                            if(controller.ordersList[index].status.toString()=="retrieved")
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.orange,
                                  border: Border.all(color: Colors.transparent),
                                  borderRadius: BorderRadius.all(Radius.circular(8)),
                                ),
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height*0.04,
                                child: Text(myStrings.retrieved,style: TextStyle(color: Colors.white),),
                                alignment: Alignment.center,
                              ),

                          ],
                        ),
                      );
                    }),
              ),
            );
            else

              return Expanded(child:Center(child: CircularProgressIndicator(color: myColors.coll,)));




          }),
        ],
      ),
    );
  }
}
