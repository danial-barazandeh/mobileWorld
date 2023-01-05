import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jmob/Pages/About/About.dart';
import 'package:jmob/Pages/About/AboutBinding.dart';
import 'package:jmob/Pages/Home/Home.dart';
import 'package:jmob/Pages/Home/HomeBinding.dart';
import 'package:jmob/Pages/SignUpForm/SignUpForm.dart';
import 'package:jmob/Pages/SignUpForm/SignUpFormBinding.dart';
import 'package:jmob/Pages/SignUpForm/SignUpFormController.dart';
import 'package:jmob/Services/MyColors.dart';
import 'package:jmob/Services/MyStrings.dart';
import 'MyDrawerController.dart';

class MyPerfectDrawer extends GetView<MyDrawerController> {
  final controller = Get.put(MyDrawerController());

  @override
  Widget build(BuildContext context) {
    final myColors = Get.find<MyColors>();
    final myStrings = Get.find<MyStrings>();


    return Container(
      width: MediaQuery.of(context).size.width,
      color: myColors.primary,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Obx(
                () => AnimatedContainer(
              duration: Duration(milliseconds: 250),
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width * 0.4,
              margin: EdgeInsets.only(top: 16, right: 0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: controller.homeColor.value,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(4),
                    topLeft: Radius.circular(4),
                  )),
              child: GestureDetector(
                onTap: (){controller.selectHome(); Get.to(() => Home(),binding: HomeBinding());},
                child: ListTile(
                  leading: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Icon(
                      Icons.home,
                      color: controller.homeTextColor.value,
                    ),
                  ),
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 9.0),
                    child: Text(
                      myStrings.home,
                      style: TextStyle(color: controller.homeTextColor.value),
                    ),
                  ),
                ),
              ),
            ),
          ),

          Obx(
                () => AnimatedContainer(
              duration: Duration(milliseconds: 250),
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width * 0.4,
              margin: EdgeInsets.only(top: 8, right: 0),
              alignment: Alignment.centerRight,
              decoration: BoxDecoration(
                  color: controller.startKitoColor.value,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(4),
                    topLeft: Radius.circular(4),
                  )),
              child: GestureDetector(
                onTap:(){
                  controller.selectStartKito();
                  Get.to(() => SignUpForm(),binding: SignUpFormBinding());
                  SignUpFormController signUpFormController = Get.find<SignUpFormController>();
                  signUpFormController.checkUser();
                  },
                child: ListTile(
                  leading: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Icon(
                      Icons.api,
                      color: controller.startKitoTextColor.value,
                    ),
                  ),
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 9.0),
                    child: Text(
                      myStrings.editAccount,
                      style: TextStyle(color: controller.startKitoTextColor.value),
                    ),
                  ),
                ),
              ),
            ),
          ),





          Obx(
                () => AnimatedContainer(
              duration: Duration(milliseconds: 250),
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width * 0.4,
              margin: EdgeInsets.only(top: 8, right: 0),
              alignment: Alignment.centerRight,
              decoration: BoxDecoration(
                  color: controller.aboutColor.value,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(4),
                    topLeft: Radius.circular(4),
                  )),
              child: GestureDetector(
                onTap: (){

                  controller.selectAbout();
                  Get.to(() => About(),binding: AboutBinding());

                  },
                child: ListTile(
                  leading: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Icon(
                      Icons.info,
                      color: controller.aboutTextColor.value,
                    ),
                  ),
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 9.0),
                    child: Text(
                      myStrings.about,
                      style: TextStyle(color: controller.aboutTextColor.value),
                    ),
                  ),
                ),
              ),
            ),
          ),


          Obx(
                () => AnimatedContainer(
              duration: Duration(milliseconds: 250),
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width * 0.4,
              margin: EdgeInsets.only(top: 8, right: 0),
              alignment: Alignment.centerRight,
              decoration: BoxDecoration(
                  color: controller.aboutColor.value,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(4),
                    topLeft: Radius.circular(4),
                  )),
              child: GestureDetector(
                onTap: (){

                  // print("wtf");

                  var storage =  GetStorage("userStorage");
                  storage.erase();
                  Phoenix.rebirth(context);

                },
                child: ListTile(
                  leading: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Icon(
                      Icons.exit_to_app,
                      color: controller.aboutTextColor.value,
                    ),
                  ),
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 9.0),
                    child: Text(
                      myStrings.exit,
                      style: TextStyle(color: controller.aboutTextColor.value),
                    ),
                  ),
                ),
              ),
            ),
          ),


        ],
      ),
    );
  }
}