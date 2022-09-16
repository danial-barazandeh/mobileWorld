import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:jmob/Pages/SearchPage/SearchPage.dart';
import 'package:jmob/Pages/SearchPage/SearchPageController.dart';
import 'package:jmob/Pages/SignUpForm/SignUpFormController.dart';
import 'package:jmob/Services/MyColors.dart';
import 'package:jmob/Services/MyStrings.dart';


class SearchPageBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(SearchPageController());
  }
}