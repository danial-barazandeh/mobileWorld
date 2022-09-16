import 'dart:convert';
import 'dart:developer';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jmob/Model/User.dart';
import 'package:jmob/Pages/Home/Home.dart';
import 'package:jmob/Pages/Home/HomeBinding.dart';
import 'package:jmob/Pages/Home/HomeController.dart';
import 'package:jmob/Pages/SignIn/SignIn.dart';
import 'package:jmob/Pages/SignIn/SignInController.dart';
import 'package:jmob/Services/BackendServices.dart';
import 'package:jmob/Services/MyColors.dart';
import 'package:jmob/Services/MyStrings.dart';
import 'package:http/http.dart' as http;
import 'package:jmob/Widget/Drawer/MyDrawerController.dart';
import 'package:jmob/Widget/Drawer/MyPerfectDrawer.dart';

class SignUpFormController extends GetxController {
  var phoneNumber = "Default".obs;
  var email = "sssss".obs;
  var name = "".obs;
  var familyName = "".obs;
  var country = "Iraq".obs;
  var city = "".obs;
  var address = "".obs;

  var nameController = new TextEditingController().obs;
  var familyNameController = new TextEditingController().obs;
  var emailController = new TextEditingController().obs;
  var countryController = new TextEditingController().obs;
  var cityController = new TextEditingController().obs;
  var addressController = new TextEditingController().obs;


  var isLoading = false.obs;
  var userList = <JmobUser>[].obs;
  MyStrings myStrings = Get.find<MyStrings>();
  static var  myColors = Get.find<MyColors>();
  var isSignUpLoading = false.obs;

  static var  signInController = Get.find<SignInController>();


  Future<void> checkUser() async {


    var storage = GetStorage("userStorage");
    var data =  await storage.read('user') ?? "empty";

    if(data.toString() == "empty") {
      Get.dialog(
          AlertDialog(
              content: Container(
                height: 250,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Flexible(
                      child: Text(myStrings.explainSignIn,
                        overflow: TextOverflow.fade,
                        maxLines: 4,
                        softWrap: true,),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          style: ButtonStyle(
                              shadowColor: MaterialStateProperty.all<Color>(myColors.primary),
                              backgroundColor: MaterialStateProperty.all<Color>(myColors.primary),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0),
                              )
                              )
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            width: 100,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(myStrings.nah,style: TextStyle(color: Colors.white),),
                            ),
                          ),
                          onPressed: () {
                            Get.to(() => Home());
                          },
                          // ** result: returns this value up the call stack **
                        ),
                        SizedBox(width: 5,),
                        TextButton(
                            style: ButtonStyle(
                                shadowColor: MaterialStateProperty.all<Color>(myColors.coll),
                                backgroundColor: MaterialStateProperty.all<Color>(myColors.coll),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                  )
                                )
                            ),
                          child: Container(
                            width: 100,
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(myStrings.login+" / "+myStrings.signUp,style: TextStyle(color: Colors.white),),
                            ),
                          ),
                          onPressed: (){
                              // Get.back(result:true);
                              Get.to(SignIn());

                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),

          )
      ).then((value) => Get.back());
    }
  }


  Future getUser() async {
    var storage =  GetStorage("userStorage");
    var data =  await storage.read('user') ?? "empty";
    if(data.toString() != "empty") {

      print("------------------");
      print(data.toString());
      print("------------------");

      JmobUser user = JmobUser.fromJson(data);
      userList.clear();
      userList.add(user);
      phoneNumber.value = user.phone;
      email.value = user.email;
      name.value = user.name;
      familyName.value = user.familyName;
      print("email length: "+email.value.length.toString());
      print("user is loged: " + user.phone);
      nameController.value.text = user.name.toString().contains("null")?"ثبت نشده":user.name;
      familyNameController.value.text = user.familyName.toString().contains("null")?"ثبت نشده":user.familyName;
      emailController.value.text = user.email.toString().contains("null")?"ثبت نشده":user.email;
      countryController.value.text = user.country.toString().contains("null")?"ثبت نشده":user.country;
      cityController.value.text = user.city.toString().contains("null")?"ثبت نشده":user.city;
      addressController.value.text = user.address.toString().contains("null")?"ثبت نشده":user.address;
    }else{
      print("user Logging is failed");
    }
  }



  void changePhoneNumber(String data){
    phoneNumber.value = data;
    update();
  }


  Future updateUser() async {
    isLoading(true);
    var storage =  GetStorage("userStorage");
    var data =  await storage.read('user') ?? "empty";
    if(data.toString() != "empty") {
      JmobUser user = JmobUser.fromJson(data);
      user.address = addressController.value.text;
      user.city = cityController.value.text;
      user.country = country.value;
      user.email = emailController.value.text;
      user.name = nameController.value.text;
      user.familyName = familyNameController.value.text;

      var inComingData = await BackendServices.updateUser(user);
      if(inComingData == null){
        Get.snackbar(
          myStrings.error,
          myStrings.errorOccurred,
          backgroundColor: myColors.coll.withAlpha(200),
          icon: Icon(Icons.lock, color: Colors.white),
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
        );
      }else{
        await storage.erase();
        await storage.write('user',inComingData.toJson());
        MyDrawerController myDrawerController = Get.find<MyDrawerController>();
        myDrawerController.selectHome();
        Get.to(()=>Home(),binding:HomeBinding());
      }
    }else{
      Get.snackbar(
        myStrings.error,
        myStrings.errorOccurred,
        backgroundColor: myColors.coll.withAlpha(200),
        icon: Icon(Icons.lock, color: Colors.white),
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
      );
    }
    isLoading(false);
  }
  //
  // Future updateUser() async {
  //   isLoading(true);
  //   var storage =  GetStorage("userStorage");
  //   var data =  await storage.read('user') ?? "empty";
  //   if(data.toString() != "empty") {
  //     WordpressUser user = WordpressUser.fromJson(data);
  //     var inComingData = await BackendServices.updateUser(user.token,user.id, email.value, name.value, familyName.value);
  //     if(inComingData == null){
  //       Get.snackbar(
  //         myStrings.error,
  //         myStrings.errorOccurred,
  //         backgroundColor: myColors.coll.withAlpha(200),
  //         icon: Icon(Icons.lock, color: Colors.white),
  //         snackPosition: SnackPosition.BOTTOM,
  //         colorText: Colors.white,
  //       );
  //     }else{
  //       await storage.erase();
  //       WordpressUser updatedUser = new WordpressUser(
  //           id:inComingData.id,
  //           firstName:inComingData.firstName,
  //           familyName: inComingData.familyName,
  //           email: inComingData.email,
  //           token: user.token,
  //           phone: user.phone,);
  //       await storage.write('user',updatedUser.toJson());
  //       MyDrawerController myDrawerController = Get.find<MyDrawerController>();
  //       myDrawerController.selectHome();
  //       Get.to(()=>Home(),binding:HomeBinding());
  //     }
  //   }else{
  //     Get.snackbar(
  //       myStrings.error,
  //       myStrings.errorOccurred,
  //       backgroundColor: myColors.coll.withAlpha(200),
  //       icon: Icon(Icons.lock, color: Colors.white),
  //       snackPosition: SnackPosition.BOTTOM,
  //       colorText: Colors.white,
  //     );
  //   }
  //   isLoading(false);
  // }

}