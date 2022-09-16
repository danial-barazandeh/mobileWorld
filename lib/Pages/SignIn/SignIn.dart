import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:jmob/Pages/Home/Home.dart';
import 'package:jmob/Services/MyColors.dart';
import 'package:jmob/Services/MyStrings.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:slide_countdown/slide_countdown.dart';

import 'SignInController.dart';

class SignIn extends GetView<SignInController> {
  TextEditingController phoneNumberController = new TextEditingController();
  String initialCountry = 'NG';
  PhoneNumber number = PhoneNumber(isoCode: 'NG');
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String temp = "";
  String tempCountryCode = "";
  String tempPhoneNumber = "";

  SignInController signInController = Get.find<SignInController>();
  MyColors myColors = Get.find<MyColors>();
  MyStrings myStrings = Get.find<MyStrings>();

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  TextEditingController pinController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    MyColors myColors = new MyColors();
    MyStrings myStrings = new MyStrings();

    return Scaffold(
        backgroundColor: myColors.primary,
        body: Form(
          key: _formKey,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(top: 40),
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    Image.asset(
                      'images/profile.png',
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width * 0.4,
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 12),
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Column(
                          children: [

                            Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: Column(
                                children: [
                                  InternationalPhoneNumberInput(
                                    textStyle: TextStyle(color: myColors.primary),
                                    onInputChanged: (PhoneNumber number) {
                                      tempCountryCode = number.props[2].toString();
                                      tempPhoneNumber =
                                          number.phoneNumber.toString().replaceFirst(number.props[2].toString(), "");
                                      temp = number.phoneNumber.toString();
                                    },
                                    onInputValidated: (bool value) {
                                      print(value);
                                    },
                                    selectorConfig: SelectorConfig(
                                      selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                                    ),
                                    ignoreBlank: false,
                                    autoValidateMode: AutovalidateMode.disabled,
                                    selectorTextStyle: TextStyle(color: myColors.primary),
                                    initialValue: number,
                                    textFieldController: phoneNumberController,
                                    formatInput: false,
                                    keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
                                    inputBorder: OutlineInputBorder(),
                                    inputDecoration: InputDecoration(
                                        focusedBorder:
                                            UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                                        enabledBorder:
                                            UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent))),
                                    onSaved: (PhoneNumber number) {
                                      print('On Saved: $number');
                                      temp = number.phoneNumber.toString();
                                    },
                                  ),
                                  SizedBox(height: 4),
                                  Container(
                                    color: myColors.primary,
                                    height: 1,
                                  ),
                                ],
                              ),
                            ),

                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: Obx(() {
                                if (signInController.isWaitingForCode.value == true)
                                  return Directionality(
                                    textDirection: TextDirection.ltr,
                                    child: PinCodeTextField(
                                      controller: pinController,
                                      keyboardType: TextInputType.number,
                                      length: 6,
                                      obscureText: false,
                                      animationType: AnimationType.fade,
                                      animationDuration: Duration(milliseconds: 300),
                                      onSubmitted: (value) {
                                        signInController.verifyCode(value);
                                      },
                                      onCompleted: (String value) {
                                        signInController.verifyCode(value);
                                      },
                                      appContext: context,
                                      onChanged: (String value) {},
                                    ),
                                  );
                                else
                                  return Text(signInController.status.value, style: TextStyle(color: myColors.coll));
                              }),
                            ),

                            SizedBox(height: 128),

                            Column(
                              children: [
                                Column(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context).size.width * 0.7,
                                          child: TextButton(
                                            style: ButtonStyle(
                                                backgroundColor: MaterialStateProperty.all<Color>(myColors.coll),
                                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                  side: BorderSide(color: myColors.coll, width: 1),
                                                  borderRadius: BorderRadius.circular(14.0),
                                                ))),
                                            onPressed: () {
                                              if (phoneNumberController.value.text.length >= 10) {
                                                pinController.clear();
                                                signInController.newAgeVerifyPhoneNumberForRegister(tempCountryCode, tempPhoneNumber);
                                              } else {
                                                Get.snackbar(
                                                  myStrings.error,
                                                  myStrings.wrongNumber,
                                                  backgroundColor: myColors.coll.withAlpha(200),
                                                  icon: Icon(Icons.lock, color: Colors.white),
                                                  snackPosition: SnackPosition.BOTTOM,
                                                  colorText: Colors.white,
                                                );
                                              }
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(top: 6.0, bottom: 6, left: 64, right: 64),
                                              child: Text(
                                                myStrings.signUp + " /  " + myStrings.login,
                                                style: TextStyle(color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 16),
                                      ],
                                    ),
                                SizedBox(
                                  height: 16,
                                ),

                                Obx(() {
                                  if(signInController.isLoading.value)
                                    return Center(child: CircularProgressIndicator(color: myColors.coll,));
                                  else
                                    return SizedBox();
                                })
                              ],
                            ),


                            GestureDetector(
                                child: Text(
                                  myStrings.home,
                                  style: TextStyle(color: myColors.primary),
                                ),
                              onTap: (){
                                  Get.to(Home());
                              },
                            ),


                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
