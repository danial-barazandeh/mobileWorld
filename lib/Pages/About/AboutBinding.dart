import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:jmob/Pages/About/AboutController.dart';
import 'package:jmob/Pages/PhoneModelView/PhoneModelViewController.dart';
import 'package:jmob/Services/MyColors.dart';
import 'package:jmob/Services/MyStrings.dart';

class AboutBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(AboutController());
    Get.put(MyColors());
    Get.put(MyStrings());
  }
}