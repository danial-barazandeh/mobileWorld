import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:jmob/Services/BackendServices.dart';
import 'package:jmob/Services/MyColors.dart';
import 'package:jmob/Services/MyStrings.dart';
import 'package:jmob/Widget/BrandWidget.dart';
import 'package:jmob/Widget/Slider/MainSlider.dart';
import 'package:jmob/Widget/ProductWidget.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:woocommerce/models/product_category.dart';
import '../OrdersView/OrdersViewController.dart';
import 'ProductController.dart';

class ProductView extends GetView<ProductController> {
  ProductController productController = Get.find<ProductController>();


  @override
  Widget build(BuildContext context) {
    MyColors myColors = new MyColors();
    MyStrings myStrings = new MyStrings();

    // productController.getProducts();

    return Scaffold(
        backgroundColor: myColors.background,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
              margin: EdgeInsets.only(top:35),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.menu,
                        color: myColors.textColor),
                    onPressed:() {
                      Get.snackbar(
                        myStrings.error,
                        myStrings.notProgrammedYet,
                        icon: Icon(Icons.lock, color: Colors.white),
                        snackPosition: SnackPosition.BOTTOM,
                        colorText: Colors.white,
                        backgroundColor: myColors.coll.withAlpha(200),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right:8),
                    child: Text(
                      productController.selectedProductCategory.value.name??"",
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

            Card(
              elevation:0,
              color: myColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(250),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(myStrings.choseYourPart,style: TextStyle(color: Colors.white),),
              ),
            ),
            SizedBox(height: 2,),
            Expanded(
              child: Obx((){
                if(productController.isLoading.value)
                  return Center(child: CircularProgressIndicator(color: myColors.coll,));
                else
                  return ListView.builder(
                      padding: EdgeInsets.all(0),
                      scrollDirection: Axis.vertical,
                      itemCount: productController.productCategories.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () async {

                            // var temp = await BackendServices.addProductOrder(productController.products[index]);
                            //
                            // try{
                            //   OrdersViewController ordersViewController = Get.find<OrdersViewController>();
                            //   ordersViewController.ordersList.value = temp;
                            // }catch(e){
                            //   Get.put(OrdersViewController);
                            //   OrdersViewController ordersViewController = Get.find<OrdersViewController>();
                            //   ordersViewController.ordersList.value = temp;
                            // }
                            //
                            // print("Salam");
                            // print(temp);
                            // print("Salam");
                          },
                          child: ProductWidget(productController.products[index]),
                        );
                      }
                  );}
              ),
            )

          ],
        )
    );
  }
}
