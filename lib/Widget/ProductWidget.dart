import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:jmob/Model/Product.dart';
import 'package:jmob/Pages/Home/Home.dart';
import 'package:jmob/Pages/Home/HomeBinding.dart';
import 'package:jmob/Pages/ProductView/ProductController.dart';
import 'package:jmob/Pages/VendorPage/VendorPage.dart';
import 'package:jmob/Pages/VendorPage/VendorPageBinding.dart';
import 'package:jmob/Pages/VendorPage/VendorPageController.dart';
import 'package:jmob/Services/MyColors.dart';
import 'package:jmob/Services/MyStrings.dart';
import 'package:woocommerce/models/product_category.dart';
import 'package:woocommerce/models/products.dart';

import '../Pages/OrdersView/OrdersViewController.dart';
import '../Services/BackendServices.dart';
import 'Drawer/MyDrawerController.dart';


class ProductWidget extends StatelessWidget {
  final Product product;

  const ProductWidget(this.product);

  String getPrice(String data){
    var nf = new NumberFormat.currency(name: 'EUR',symbol: "€").format(int.parse(data.toString()));
    return nf.toString();
  }

  @override
  Widget build(BuildContext context) {

    // print("/////////////////");
    // print(product.storeFeatured);
    // print("/////////////////");

    MyStrings myStrings = Get.find<MyStrings>();
    MyColors myColors = new MyColors();
    String imageCheck = "";


    try {
      imageCheck = product.image.toString();
    }catch (e) {
      imageCheck = "";
    }

    return Container(
      child: Card(
        color: Color(0xffeaf2ff),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                // if(imageCheck.length > 1)
                // Padding(
                //   padding: const EdgeInsets.only(right: 0,top: 0,bottom: 0),
                //   child: ClipRRect(
                //     borderRadius: BorderRadius.horizontal(right: Radius.circular(16)),
                //      child: Image.network(product.images.first.src.toString(),
                //       height: MediaQuery.of(context).size.height*0.15,
                //       width: MediaQuery.of(context).size.width*0.4,
                //        fit: BoxFit.cover,
                //     ),
                //   ),
                // ),

                // if(imageCheck.length < 1)
                //   Padding(
                //     padding: const EdgeInsets.only(right: 0,top: 0,bottom: 0),
                //     child: ClipRRect(
                //       borderRadius: BorderRadius.horizontal(right: Radius.circular(16)),
                //       child: Image.asset("images/empty.png",
                //         height: MediaQuery.of(context).size.height*0.15,
                //         width: MediaQuery.of(context).size.width*0.4,
                //         fit: BoxFit.cover,
                //       ),
                //     ),
                //   ),

                SizedBox(width: 8,),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [


                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Padding(
                            padding: const EdgeInsets.only(top:8.0,right: 8,left: 8),
                            child: Text(product.name.toString(),style: TextStyle(fontSize: 12),textAlign: TextAlign.start,),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top:8.0,right: 8,left: 8,bottom: 8),
                            child: Text(product.content??"",textAlign: TextAlign.start,style: TextStyle(fontSize: 10)),
                          ),

                        ],
                      ),


                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [


                            if(product.salePrice.toString().length>0)
                              Text(getPrice(product.price.toString()),style: TextStyle(color: Colors.red,decoration: TextDecoration.lineThrough, fontSize: 10),),

                            if(product.salePrice.toString().length>0)
                              Text(getPrice(product.salePrice.toString()),style: TextStyle(color: Color(0xff113045), fontSize: 12)),


                            if(product.salePrice.toString().length < 1)
                              Text(getPrice(product.price.toString()),style: TextStyle(color: Color(0xff113045), fontSize: 12),),

                          ],
                        ),
                      ),



                      Padding(
                        padding: const EdgeInsets.only(left: 8,right: 8),
                        child: SizedBox(
                          height:MediaQuery.of(context).size.height*0.04,
                          width:MediaQuery.of(context).size.width*0.12,
                          child: TextButton(
                            onPressed: () async {


                              var storage = GetStorage("userStorage");
                              var data =  await storage.read('user') ?? "empty";

                              if(data.toString() == "empty") {
                                Get.snackbar(
                                  myStrings.error,
                                  myStrings.registerForBuying,
                                  icon: Icon(Icons.lock, color: Colors.white),
                                  snackPosition: SnackPosition.BOTTOM,
                                  colorText: Colors.white,
                                  backgroundColor: myColors.coll.withAlpha(200),
                                );

                              }else {
                                var temp = await BackendServices.addProductOrder(product);
                                try{
                                  OrdersViewController ordersViewController = Get.find<OrdersViewController>();
                                  ordersViewController.ordersList.value = temp;
                                  ordersViewController.isLoaded(true);
                                }catch(e){
                                  Get.put(OrdersViewController());
                                  OrdersViewController ordersViewController = Get.find<OrdersViewController>();
                                  ordersViewController.ordersList.value = temp;
                                  ordersViewController.isLoaded(true);
                                }
                                Get.snackbar(
                                  myStrings.ordersList,
                                  myStrings.addedToOrdersList,
                                  icon: Icon(Icons.lock, color: Colors.white),
                                  snackPosition: SnackPosition.BOTTOM,
                                  colorText: Colors.white,
                                  backgroundColor: myColors.coll.withAlpha(200),
                                );
                              }


                            },
                            child: Text("Buy",style: TextStyle(color: Colors.white, fontSize: 12)),
                            style: TextButton.styleFrom(primary: Colors.white,backgroundColor: myColors.coll),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),





              ],
            ),





            GestureDetector(
              onTap: (){
                print("sssssssssssss");
                VendorPageController vendorPageController = Get.find<VendorPageController>();
                vendorPageController.vendor.value = product.vendor;
                Get.to(VendorPage());
              },
              child: Container(
                decoration: BoxDecoration(
                  color: myColors.primary,
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(8),bottomLeft: Radius.circular(8)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.store,color: myColors.background,),
                          SizedBox(width: 8,),
                          Text(product.vendor.name,style: TextStyle(color: Colors.white)),
                        ],
                      ),

                    ],
                  ),
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}