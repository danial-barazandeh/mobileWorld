import 'package:get/get.dart';
import 'package:jmob/Pages/Profile/ProfileController.dart';

import 'VendorPageController.dart';

class VendorPageBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(VendorPageController());
  }
}