import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jmob/Pages/Home/Home.dart';
import 'package:jmob/Pages/Home/HomeBinding.dart';
import 'package:jmob/Pages/OrdersView/OrdersView.dart';
import 'package:jmob/Pages/Profile/Profile.dart';
import 'package:jmob/Pages/Profile/ProfileBinding.dart';
import 'package:jmob/Pages/SearchPage/SearchPage.dart';
import 'package:jmob/Pages/SearchPage/SearchPageBinding.dart';
import 'package:jmob/Pages/SignUpForm/SignUpForm.dart';
import 'package:jmob/Pages/SignUpForm/SignUpFormBinding.dart';
import 'package:jmob/Pages/SignUpForm/SignUpFormController.dart';
import 'package:jmob/Services/MyColors.dart';
import 'package:jmob/Widget/Drawer/MyDrawerController.dart';
import 'package:jmob/Widget/Drawer/MyPerfectDrawer.dart';
import 'package:woocommerce/models/product_category.dart';

import '../../Pages/OrdersView/OrdersViewBinding.dart';
import 'ButtomNavigationController.dart';


class ButtomNavigation extends GetView<BottomNavigationController> {

  @override
  Widget build(BuildContext context) {

    final myPerfectDrawer = Get.find<MyPerfectDrawer>();
    final myDrawerController = Get.find<MyDrawerController>();
    MyColors myColors = Get.find<MyColors>();
    BottomNavigationController controller = Get.find<BottomNavigationController>();

    var temp = <Widget>[
      Icon(Icons.account_circle, size: 30,color: myColors.background,),
      Icon(Icons.home, size: 30,color: myColors.background),
      Icon(Icons.list, size: 30,color: myColors.background),
      Icon(Icons.search, size: 30,color: myColors.background),
    ];



    if(controller.page < temp.length)
      return Obx(
        ()=> CurvedNavigationBar(
          index: controller.page.value,
          height: 60.0,
          items: temp,
          color: myColors.primary,
          buttonBackgroundColor: myColors.primary,
          backgroundColor: myColors.coll,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 200),
          onTap: (index) {
            print(index.toString());

            if(index == 0) {
              myDrawerController.selectStartKitoFromButtonNavBar();
              Get.to(() => SignUpForm(), binding: SignUpFormBinding());
              SignUpFormController signUpFormController = Get.find<SignUpFormController>();
              signUpFormController.checkUser();
            }
            else if(index == 1) {
              myDrawerController.selectHome();
              Get.to(() => Home(), binding: HomeBinding());
            }
            else if(index == 2) {
              Get.to(() => OrdersView(), binding: OrdersViewBinding());
            }
            else if(index == 3) {
              Get.to(() => SearchPage(), binding: SearchPageBinding());
            }

          },
          letIndexChange: (index) => true,
        ),
      );
    else{
      return Obx(
        ()=> CurvedNavigationBar(
          index: controller.page.value,
          height: 60.0,
          items: temp,
          color: myColors.primary,
          buttonBackgroundColor: myColors.primary,
          backgroundColor: myColors.primary,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 200),
          onTap: (index) {
            print(index.toString());

            if(index == 0) {
              myDrawerController.selectStartKitoFromButtonNavBar();
              Get.to(() => SignUpForm(), binding: SignUpFormBinding());
              SignUpFormController signUpFormController = Get.find<SignUpFormController>();
              signUpFormController.checkUser();
            }
            else if(index == 1) {
              myDrawerController.selectHome();
              Get.to(() => Home(), binding: HomeBinding());
            }
            else if(index == 2) {
              Get.to(() => OrdersView(), binding: OrdersViewBinding());
            }
            else if(index == 3) {
              Get.to(() => SearchPage(), binding: SearchPageBinding());
            }

          },
          letIndexChange: (index) => true,
        ),
      );
    }

  }
}