import 'package:get/get.dart';
import 'package:jmob/Pages/Profile/ProfileController.dart';

class ProfileBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(ProfileController());
  }
}