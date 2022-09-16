import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:jmob/Pages/PhoneModelView/PhoneModelViewController.dart';
import 'package:jmob/Services/MyColors.dart';
import 'package:jmob/Services/MyStrings.dart';
import 'package:jmob/Widget/Drawer/MyPerfectDrawer.dart';

import 'HomeController.dart';

class HomeBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(HomeController());
    Get.put(MyColors());
    Get.put(MyStrings());
    Get.put(MyPerfectDrawer());
  }
}