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


class ProductWidgetMultilevel extends StatelessWidget {
  final List<Product> products;
  const ProductWidgetMultilevel(this.products);

  String getPrice(String data){
    var nf = new NumberFormat.currency(name: 'IRR',symbol: "").format(int.parse(data.toString()));
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


    // try {
    //   imageCheck = product.image.toString();
    // }catch (e) {
    //   imageCheck = "";
    // }

    return Container(
      decoration: new BoxDecoration(
        color: Color(0xffeaf2ff),
        borderRadius: BorderRadius.only(topRight: Radius.circular(8),topLeft: Radius.circular(8)),
      ),
      child: Column(
        children: [
          ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.all(0),
              scrollDirection: Axis.vertical,
              itemCount: products.length,
              itemBuilder: (context,index){
            return Column(
              children: [
                GestureDetector(
                  onTap: () async {

                    // print("*************************");
                    // print(product.store);
                    // print("*************************");

                    // VendorPageController vendorPageController = Get.find<VendorPageController>();
                    // vendorPageController.vendorID.value = product.store??0;
                    // var isVendorOk = await vendorPageController.fetchVendors();
                    // if(isVendorOk == false){
                    //   MyDrawerController myDrawerController = Get.find<MyDrawerController>();
                    //   myDrawerController.selectHome();
                    //   // Get.to(() => Home(), binding: HomeBinding());
                    //   Get.snackbar(
                    //     myStrings.error,
                    //     myStrings.notVendorInfo,
                    //     icon: Icon(Icons.lock, color: Colors.white),
                    //     snackPosition: SnackPosition.BOTTOM,
                    //     colorText: Colors.white,
                    //     backgroundColor: myColors.coll.withAlpha(200),
                    //   );
                    // }else{
                    //   Get.to(() => VendorPage());
                    //   // vendorPageController.fetchVendors();
                    // }

                  },
                  child: Container(
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
                                        padding: const EdgeInsets.only(top:8.0,right: 0,left: 0),
                                        child: Text(products[index].name.toString(),style: TextStyle(fontSize: 12),textAlign: TextAlign.start,),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.only(top:8.0,right: 0,left: 0,bottom: 8),
                                        child: Text(products[index].content??"",textAlign: TextAlign.start,style: TextStyle(fontSize: 10)),
                                      ),

                                    ],
                                  ),


                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [


                                        if(products[index].salePrice.toString().length>0)
                                          Text(getPrice(products[index].price.toString()),style: TextStyle(color: Colors.red,decoration: TextDecoration.lineThrough, fontSize: 10),),

                                        if(products[index].salePrice.toString().length>0)
                                          Text(getPrice(products[index].salePrice.toString()),style: TextStyle(color: Color(0xff113045), fontSize: 12)),


                                        if(products[index].salePrice.toString().length < 1)
                                          Text(getPrice(products[index].price.toString()),style: TextStyle(color: Color(0xff113045), fontSize: 12),),

                                      ],
                                    ),
                                  ),


                                  Padding(
                                    padding: const EdgeInsets.only(left: 4.0),
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
                                            var temp = await BackendServices.addProductOrder(products[index]);
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
                                        child: Text("خرید",style: TextStyle(color: Colors.white, fontSize: 12)),
                                        style: TextButton.styleFrom(primary: Colors.white,backgroundColor: Colors.red),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),


                          ],
                        ),





                      ],
                    ),
                  ),
                ),


                Container(height: 2,width: MediaQuery.of(context).size.width,color: Colors.black12,),
              ],
            );

          }),





          Container(
            decoration: BoxDecoration(
              color: Color(0xff113045),
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(8),bottomLeft: Radius.circular(8)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.store,color: Color(0xfffcc906),),
                      SizedBox(width: 8,),

                      Text(products.first.user.toString(),style: TextStyle(color: Colors.white)),

                    ],
                  ),



                  // if(product.storeFeatured == true)
                  //   Row(
                  //     children: [
                  //       Icon(Icons.check_circle_outlined,color: Color(0xff04eb84)),
                  //       SizedBox(width: 8,),
                  //       Text(myStrings.verifiedStore,style: TextStyle(color: Colors.white)),
                  //     ],
                  //   )


                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}