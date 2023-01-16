
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:jmob/Services/MyColors.dart';

class MyDrawerController extends GetxController{


  static MyColors myColors = Get.find<MyColors>();

  var homeColor = Color.fromRGBO(255, 255, 255, 0).obs;
  var homeTextColor = Color.fromRGBO(233,233,234, 1).obs;


  var startKitoColor = Color.fromRGBO(255, 255, 255, 0).obs;
  var startKitoTextColor = Color.fromRGBO(233,233,234, 1).obs;


  var aboutColor = Color.fromRGBO(255, 255, 255, 0).obs;
  var aboutTextColor = Color.fromRGBO(233,233,234, 1).obs;

  var exitColor = Color.fromRGBO(255, 255, 255, 0).obs;
  var exitTextColor = Color.fromRGBO(233,233,234, 1).obs;


  Color setColor = Colors.white;
  Color setBackground = myColors.coll;
  Color notSet = Colors.white;
  Color notSetBackground = myColors.primary;

  var backgroundColor = Colors.transparent.obs;

  @override
  void onInit() {
    selectHome();
    super.onInit();
  }

  void selectHome(){
    homeColor.value = setBackground;
    homeTextColor.value = setColor;

    startKitoColor.value = notSetBackground;
    startKitoTextColor.value = notSet;
    aboutColor.value = notSetBackground;
    aboutTextColor.value = notSet;

    Timer(
        Duration(milliseconds: 250),
            () => {
          CloseDrawer()
        });
  }


  void selectStartKito(){
    startKitoColor.value = setBackground;
    startKitoTextColor.value = setColor;

    homeColor.value = notSetBackground;
    homeTextColor.value = notSet;
    aboutColor.value = notSetBackground;
    aboutTextColor.value = notSet;

    Timer(
        Duration(milliseconds: 250),
            () => {
          CloseDrawer()
        });
  }

  void selectStartKitoFromButtonNavBar(){
    startKitoColor.value = setBackground;
    startKitoTextColor.value = setColor;

    homeColor.value = notSetBackground;
    homeTextColor.value = notSet;
    aboutColor.value = notSetBackground;
    aboutTextColor.value = notSet;
  }


  void selectAbout(){
    aboutColor.value = setBackground;
    aboutTextColor.value = setColor;

    homeColor.value = notSetBackground;
    homeTextColor.value = notSet;
    startKitoColor.value = notSetBackground;
    startKitoTextColor.value = notSet;

    Timer(
        Duration(milliseconds: 250),
            () => {
          CloseDrawer()
        });
  }
  //Controlling the Navbar across the app
  var xOffset = 1.5.obs;
  var yOffset = 2.5.obs;
  var scaleFactor = 1.0.obs;
  var isDrawerOpen = false.obs;
  var num = 10.0.obs;

  void CloseDrawer(){
    yOffset.value = 0.0;
    xOffset.value = 0.0;
    scaleFactor.value = 1.0;
    isDrawerOpen.value = false;
    backgroundColor.value = Colors.transparent;
    update();
  }

  void OpenDrawer(BuildContext context){
    yOffset.value = 50;
    xOffset.value = -100;
    scaleFactor.value = 0.8;
    isDrawerOpen.value = true;
    backgroundColor.value = Color.fromRGBO(0, 0, 0, 0.4);
    update();
  }
}