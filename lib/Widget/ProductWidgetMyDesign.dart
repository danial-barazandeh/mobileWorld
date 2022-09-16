import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:jmob/Pages/Home/Home.dart';
import 'package:jmob/Pages/Home/HomeBinding.dart';
import 'package:jmob/Pages/VendorPage/VendorPage.dart';
import 'package:jmob/Pages/VendorPage/VendorPageBinding.dart';
import 'package:jmob/Pages/VendorPage/VendorPageController.dart';
import 'package:jmob/Services/MyColors.dart';
import 'package:jmob/Services/MyStrings.dart';
import 'package:woocommerce/models/product_category.dart';
import 'package:woocommerce/models/products.dart';

import 'Drawer/MyDrawerController.dart';


class ProductWidgetMyDesign extends StatelessWidget {
  final WooProduct product;
  const ProductWidgetMyDesign(this.product);

  String getPrice(String data){
    var nf = new NumberFormat.currency(name: 'IRR',symbol: "").format(int.parse(data.toString()));
    return nf.toString();
  }

  @override
  Widget build(BuildContext context) {

    print("/////////////////");
    print(product.storeFeatured);
    print("/////////////////");

    MyStrings myStrings = Get.find<MyStrings>();
    MyColors myColors = new MyColors();
    String imageCheck = "";


    try {
      imageCheck = product.images.first.src.toString();
    }catch (e) {
      imageCheck = "";
    }

    var body = parse(product.description);

    return GestureDetector(
      onTap: () async {

        print("*************************");
        print(product.store);
        print("*************************");

        VendorPageController vendorPageController = Get.find<VendorPageController>();
        vendorPageController.vendorID.value = product.store??0;
        var isVendorOk = await vendorPageController.fetchVendors();
        if(isVendorOk == false){
          MyDrawerController myDrawerController = Get.find<MyDrawerController>();
          myDrawerController.selectHome();
          // Get.to(() => Home(), binding: HomeBinding());
          Get.snackbar(
            myStrings.error,
            myStrings.notVendorInfo,
            icon: Icon(Icons.lock, color: Colors.white),
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.white,
            backgroundColor: myColors.coll.withAlpha(200),
          );
        }else{
          Get.to(() => VendorPage());
          // vendorPageController.fetchVendors();
        }

      },
      child: Card(
        color: myColors.background,
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
                        children: [

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(product.name.toString(),style: TextStyle(fontSize: 16),),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: HtmlWidget(product.description??""),
                          ),

                        ],
                      ),


                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [


                            if(product.salePrice.toString().length>0)
                              Text(getPrice(product.salePrice.toString()),style: TextStyle(color: Colors.green, fontSize: 16)),

                            if(product.salePrice.toString().length>0)
                              Text(getPrice(product.regularPrice.toString()),style: TextStyle(color: Colors.red,decoration: TextDecoration.lineThrough, fontSize: 16),),

                            if(product.salePrice.toString().length < 1)
                              Text(getPrice(product.regularPrice.toString()),style: TextStyle(color: Colors.green, fontSize: 16),),

                          ],
                        ),
                      ),

                    ],
                  ),
                ),


              ],
            ),





            Container(
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
                        Icon(Icons.store,color: Colors.white),
                        SizedBox(width: 8,),
                        Text(product.storeName.toString(),style: TextStyle(color: Colors.white)),
                      ],
                    ),



                    if(product.storeFeatured == true)
                      Row(
                        children: [
                          Icon(Icons.check_circle_outlined,color: Colors.white),
                          SizedBox(width: 8,),
                          Text(myStrings.verifiedStore,style: TextStyle(color: Colors.white)),
                        ],
                      )


                  ],
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}