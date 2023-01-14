import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:jmob/Services/MyColors.dart';
import 'package:jmob/Services/MyStrings.dart';
import 'package:jmob/Widget/BottomNavigation/ButtomNavigation.dart';
import 'package:jmob/Widget/Drawer/MyDrawerController.dart';
import 'package:jmob/Widget/Drawer/MyPerfectDrawer.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:slide_countdown/slide_countdown.dart';

import '../SearchPage/SearchPage.dart';
import '../SearchPage/SearchPageBinding.dart';
import 'SignUpFormController.dart';

class SignUpForm extends GetView<SignUpFormController> {
  SignUpFormController signUpFormController = Get.find<SignUpFormController>();
  MyColors myColors = Get.find<MyColors>();
  MyStrings myStrings = Get.find<MyStrings>();

  final _formKey = GlobalKey<FormState>();

  final myPerfectDrawer = Get.find<MyPerfectDrawer>();
  final myDrawerController = Get.find<MyDrawerController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: myColors.background,
        bottomNavigationBar: ButtomNavigation(),
        body: Stack(
          children: [
            myPerfectDrawer,
            Obx(
              () => AnimatedContainer(
                transform: Matrix4.translationValues(myDrawerController.xOffset.value, myDrawerController.yOffset.value * 1.5, 0)
                  ..scale(myDrawerController.scaleFactor.value),
                duration: Duration(milliseconds: 250),
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ], color: myColors.backgroundColor, borderRadius: BorderRadius.circular(myDrawerController.isDrawerOpen.value ? 30 : 0)),
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    SizedBox(
                      height: myDrawerController.isDrawerOpen.value ? 10 : 30,
                    ),
                    Stack(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                myDrawerController.isDrawerOpen.value
                                    ? Container(
                                  width: MediaQuery.of(context).size.width,
                                  alignment: Alignment.centerRight,
                                  child: IconButton(
                                    icon: Icon(Icons.arrow_forward, color: myColors.textColor),
                                    onPressed: () => myDrawerController.CloseDrawer(),
                                  ),
                                )
                                    : IconButton(
                                  icon: Icon(Icons.menu, color: myColors.textColor),
                                  onPressed: () => myDrawerController.OpenDrawer(context),
                                ),
                                !myDrawerController.isDrawerOpen.value
                                    ? Text(
                                  myStrings.editAccount,
                                  style: TextStyle(color: myColors.textColor),
                                ) : SizedBox(),
                              ],
                            ),
                            !myDrawerController.isDrawerOpen.value
                                ? Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                  icon: Icon(Icons.search, color: myColors.textColor),
                                  onPressed: () => Get.to(() => SearchPage(), binding: SearchPageBinding()),
                                ),
                              ),
                            ) : SizedBox(),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      width: MediaQuery.of(context).size.width,
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
                              padding: const EdgeInsets.all(16.0),
                              child: Form(
                                key: _formKey,
                                child: Obx(
                                  () => Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        myStrings.name,
                                        style: TextStyle(color: myColors.coll),
                                      ),
                                      TextFormField(
                                          controller: signUpFormController.nameController.value,
                                          autovalidateMode: AutovalidateMode.onUserInteraction,
                                          validator: (value) {
                                            if (!GetUtils.isLengthBetween(value, 3, 30))
                                              return myStrings.wringInput;
                                            else {
                                              return null;
                                            }
                                          },
                                          keyboardType: TextInputType.text,
                                          style: TextStyle(color: Colors.black87),
                                          decoration: new InputDecoration(
                                            errorStyle: TextStyle(color: Colors.black87),
                                            errorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black87)),
                                            focusedErrorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black87)),
                                            hintText: myStrings.name,
                                            labelStyle: TextStyle(color: Colors.black87),
                                          )),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      Text(
                                        myStrings.familyName,
                                        style: TextStyle(color: myColors.coll),
                                      ),
                                      TextFormField(
                                          controller: signUpFormController.familyNameController.value,
                                          autovalidateMode: AutovalidateMode.onUserInteraction,
                                          validator: (value) {
                                            if (!GetUtils.isLengthBetween(value, 3, 30))
                                              return myStrings.wringInput;
                                            else {
                                              return null;
                                            }
                                          },
                                          keyboardType: TextInputType.text,
                                          style: TextStyle(color: Colors.black87),
                                          decoration: new InputDecoration(
                                            errorStyle: TextStyle(color: Colors.black87),
                                            errorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black87)),
                                            focusedErrorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black87)),
                                            hintText: myStrings.familyName,
                                            labelStyle: TextStyle(color: Colors.black87),
                                          )),

                                      SizedBox(
                                        height: 16,
                                      ),

                                      Text(
                                        myStrings.phoneNumber,
                                        style: TextStyle(color: myColors.coll),
                                      ),
                                      Directionality(
                                        textDirection: TextDirection.ltr,
                                        child: TextFormField(
                                            autovalidateMode: AutovalidateMode.onUserInteraction,
                                            initialValue: signUpFormController.phoneNumber.value,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(color: Colors.black26),
                                            enabled: false,
                                            decoration: new InputDecoration(
                                              errorStyle: TextStyle(color: Colors.black26),
                                              errorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black26)),
                                              focusedErrorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black26)),
                                              hintText: myStrings.phoneNumber,
                                              disabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black.withAlpha(50))),
                                              labelStyle: TextStyle(color: Colors.black26),
                                            )),
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),

                                      Text(
                                        myStrings.emailAddress,
                                        style: TextStyle(color: myColors.coll),
                                      ),
                                      TextFormField(
                                          controller: signUpFormController.emailController.value,
                                          autovalidateMode: AutovalidateMode.onUserInteraction,
                                          validator: (value) {
                                            if (!GetUtils.isEmail(value!))
                                              return myStrings.emailIsNotValid;
                                            else {
                                              signUpFormController.email.value = value;
                                              return null;
                                            }
                                          },
                                          keyboardType: TextInputType.emailAddress,
                                          style: TextStyle(color: Colors.black87),
                                          decoration: new InputDecoration(
                                            errorStyle: TextStyle(color: Colors.black87),
                                            errorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black87)),
                                            focusedErrorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black87)),
                                            hintText: myStrings.emailAddress,
                                            labelStyle: TextStyle(color: Colors.black87),
                                          )),

                                      SizedBox(
                                        height: 16,
                                      ),

                                      Text(
                                        myStrings.country,
                                        style: TextStyle(color: myColors.coll),
                                      ),

                                      Directionality(
                                        textDirection: TextDirection.ltr,
                                        child: DropdownButton<String>(
                                          value: signUpFormController.country.value,
                                          isExpanded: true,
                                          icon: Icon(
                                            Icons.arrow_downward,
                                            size: 20,
                                            color: myColors.coll,
                                          ),
                                          elevation: 16,
                                          style: TextStyle(color: myColors.textColor),
                                          underline: Container(
                                            height: 1,
                                            color: Colors.black87,
                                          ),
                                          onChanged: (String? newValue) {
                                            signUpFormController.country.value = newValue!;
                                          },
                                          items: <String>[
                                            "Afghanistan",
                                            "Albania",
                                            "Algeria",
                                            "American Samoa",
                                            "Andorra",
                                            "Angola",
                                            "Anguilla",
                                            "Antarctica",
                                            "Antigua and Barbuda",
                                            "Argentina",
                                            "Armenia",
                                            "Aruba",
                                            "Australia",
                                            "Austria",
                                            "Azerbaijan",
                                            "Bahamas (the)",
                                            "Bahrain",
                                            "Bangladesh",
                                            "Barbados",
                                            "Belarus",
                                            "Belgium",
                                            "Belize",
                                            "Benin",
                                            "Bermuda",
                                            "Bhutan",
                                            "Bolivia (Plurinational State of)",
                                            "Bonaire, Sint Eustatius and Saba",
                                            "Bosnia and Herzegovina",
                                            "Botswana",
                                            "Bouvet Island",
                                            "Brazil",
                                            "British Indian Ocean Territory (the)",
                                            "Brunei Darussalam",
                                            "Bulgaria",
                                            "Burkina Faso",
                                            "Burundi",
                                            "Cabo Verde",
                                            "Cambodia",
                                            "Cameroon",
                                            "Canada",
                                            "Cayman Islands (the)",
                                            "Central African Republic (the)",
                                            "Chad",
                                            "Chile",
                                            "China",
                                            "Christmas Island",
                                            "Cocos (Keeling) Islands (the)",
                                            "Colombia",
                                            "Comoros (the)",
                                            "Congo (the Democratic Republic of the)",
                                            "Congo (the)",
                                            "Cook Islands (the)",
                                            "Costa Rica",
                                            "Croatia",
                                            "Cuba",
                                            "Curaçao",
                                            "Cyprus",
                                            "Czechia",
                                            "Côte d'Ivoire",
                                            "Denmark",
                                            "Djibouti",
                                            "Dominica",
                                            "Dominican Republic (the)",
                                            "Ecuador",
                                            "Egypt",
                                            "El Salvador",
                                            "Equatorial Guinea",
                                            "Eritrea",
                                            "Estonia",
                                            "Eswatini",
                                            "Ethiopia",
                                            "Falkland Islands (the) [Malvinas]",
                                            "Faroe Islands (the)",
                                            "Fiji",
                                            "Finland",
                                            "France",
                                            "French Guiana",
                                            "French Polynesia",
                                            "French Southern Territories (the)",
                                            "Gabon",
                                            "Gambia (the)",
                                            "Georgia",
                                            "Germany",
                                            "Ghana",
                                            "Gibraltar",
                                            "Greece",
                                            "Greenland",
                                            "Grenada",
                                            "Guadeloupe",
                                            "Guam",
                                            "Guatemala",
                                            "Guernsey",
                                            "Guinea",
                                            "Guinea-Bissau",
                                            "Guyana",
                                            "Haiti",
                                            "Heard Island and McDonald Islands",
                                            "Holy See (the)",
                                            "Honduras",
                                            "Hong Kong",
                                            "Hungary",
                                            "Iceland",
                                            "India",
                                            "Indonesia",
                                            "Iran (Islamic Republic of)",
                                            "Iraq",
                                            "Ireland",
                                            "Isle of Man",
                                            "Israel",
                                            "Italy",
                                            "Jamaica",
                                            "Japan",
                                            "Jersey",
                                            "Jordan",
                                            "Kazakhstan",
                                            "Kenya",
                                            "Kiribati",
                                            "Korea (the Democratic People's Republic of)",
                                            "Korea (the Republic of)",
                                            "Kuwait",
                                            "Kyrgyzstan",
                                            "Lao People's Democratic Republic (the)",
                                            "Latvia",
                                            "Lebanon",
                                            "Lesotho",
                                            "Liberia",
                                            "Libya",
                                            "Liechtenstein",
                                            "Lithuania",
                                            "Luxembourg",
                                            "Macao",
                                            "Madagascar",
                                            "Malawi",
                                            "Malaysia",
                                            "Maldives",
                                            "Mali",
                                            "Malta",
                                            "Marshall Islands (the)",
                                            "Martinique",
                                            "Mauritania",
                                            "Mauritius",
                                            "Mayotte",
                                            "Mexico",
                                            "Micronesia (Federated States of)",
                                            "Moldova (the Republic of)",
                                            "Monaco",
                                            "Mongolia",
                                            "Montenegro",
                                            "Montserrat",
                                            "Morocco",
                                            "Mozambique",
                                            "Myanmar",
                                            "Namibia",
                                            "Nauru",
                                            "Nepal",
                                            "Netherlands (the)",
                                            "New Caledonia",
                                            "New Zealand",
                                            "Nicaragua",
                                            "Niger (the)",
                                            "Nigeria",
                                            "Niue",
                                            "Norfolk Island",
                                            "Northern Mariana Islands (the)",
                                            "Norway",
                                            "Oman",
                                            "Pakistan",
                                            "Palau",
                                            "Palestine, State of",
                                            "Panama",
                                            "Papua New Guinea",
                                            "Paraguay",
                                            "Peru",
                                            "Philippines (the)",
                                            "Pitcairn",
                                            "Poland",
                                            "Portugal",
                                            "Puerto Rico",
                                            "Qatar",
                                            "Republic of North Macedonia",
                                            "Romania",
                                            "Russian Federation (the)",
                                            "Rwanda",
                                            "Réunion",
                                            "Saint Barthélemy",
                                            "Saint Helena, Ascension and Tristan da Cunha",
                                            "Saint Kitts and Nevis",
                                            "Saint Lucia",
                                            "Saint Martin (French part)",
                                            "Saint Pierre and Miquelon",
                                            "Saint Vincent and the Grenadines",
                                            "Samoa",
                                            "San Marino",
                                            "Sao Tome and Principe",
                                            "Saudi Arabia",
                                            "Senegal",
                                            "Serbia",
                                            "Seychelles",
                                            "Sierra Leone",
                                            "Singapore",
                                            "Sint Maarten (Dutch part)",
                                            "Slovakia",
                                            "Slovenia",
                                            "Solomon Islands",
                                            "Somalia",
                                            "South Africa",
                                            "South Georgia and the South Sandwich Islands",
                                            "South Sudan",
                                            "Spain",
                                            "Sri Lanka",
                                            "Sudan (the)",
                                            "Suriname",
                                            "Svalbard and Jan Mayen",
                                            "Sweden",
                                            "Switzerland",
                                            "Syrian Arab Republic",
                                            "Taiwan",
                                            "Tajikistan",
                                            "Tanzania, United Republic of",
                                            "Thailand",
                                            "Timor-Leste",
                                            "Togo",
                                            "Tokelau",
                                            "Tonga",
                                            "Trinidad and Tobago",
                                            "Tunisia",
                                            "Turkey",
                                            "Turkmenistan",
                                            "Turks and Caicos Islands (the)",
                                            "Tuvalu",
                                            "Uganda",
                                            "Ukraine",
                                            "United Arab Emirates (the)",
                                            "United Kingdom of Great Britain and Northern Ireland (the)",
                                            "United States Minor Outlying Islands (the)",
                                            "United States of America (the)",
                                            "Uruguay",
                                            "Uzbekistan",
                                            "Vanuatu",
                                            "Venezuela (Bolivarian Republic of)",
                                            "Viet Nam",
                                            "Virgin Islands (British)",
                                            "Virgin Islands (U.S.)",
                                            "Wallis and Futuna",
                                            "Western Sahara",
                                            "Yemen",
                                            "Zambia",
                                            "Zimbabwe",
                                            "Åland Islands"
                                          ].map<DropdownMenuItem<String>>((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                        ),
                                      ),

                                      SizedBox(
                                        height: 16,
                                      ),

                                      Text(
                                        myStrings.city,
                                        style: TextStyle(color: myColors.coll),
                                      ),
                                      TextFormField(
                                          controller: signUpFormController.cityController.value,
                                          autovalidateMode: AutovalidateMode.onUserInteraction,
                                          validator: (value) {

                                          },
                                          keyboardType: TextInputType.text,
                                          style: TextStyle(color: Colors.black87),
                                          decoration: new InputDecoration(
                                            errorStyle: TextStyle(color: Colors.black87),
                                            errorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black87)),
                                            focusedErrorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black87)),
                                            hintText: myStrings.city,
                                            labelStyle: TextStyle(color: Colors.black87),
                                          )),


                                      SizedBox(
                                        height: 16,
                                      ),

                                      Text(
                                        myStrings.address,
                                        style: TextStyle(color: myColors.coll),
                                      ),
                                      TextFormField(
                                          controller: signUpFormController.addressController.value,
                                          autovalidateMode: AutovalidateMode.onUserInteraction,
                                          validator: (value) {

                                          },
                                          keyboardType: TextInputType.text,
                                          style: TextStyle(color: Colors.black87),
                                          decoration: new InputDecoration(
                                            border: InputBorder.none,
                                            errorStyle: TextStyle(color: Colors.black87),
                                            errorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black87)),
                                            focusedErrorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black87)),
                                            hintText: myStrings.address,
                                            labelStyle: TextStyle(color: Colors.black87),
                                          )),
                                      // TextFormField(
                                      //     controller: signUpFormController.emailController.value,
                                      //     autovalidateMode: AutovalidateMode.onUserInteraction,
                                      //     validator: (value) {
                                      //       if (!GetUtils.isEmail(value!))
                                      //         return myStrings.emailIsNotValid;
                                      //       else{
                                      //         signUpFormController.email.value = value;
                                      //         return null;
                                      //       }
                                      //
                                      //     },
                                      //     keyboardType: TextInputType.emailAddress,
                                      //     textAlign: TextAlign.right,
                                      //     style: TextStyle(color: Colors.black87),
                                      //     decoration: new InputDecoration(
                                      //       errorStyle: TextStyle(color: Colors.black87),
                                      //       errorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black87)),
                                      //       focusedErrorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black87)),
                                      //       hintText: myStrings.emailAddress,
                                      //       labelStyle: TextStyle(color: Colors.black87),
                                      //     )),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 32,
                          ),
                          Obx(() {
                            if (!signUpFormController.isLoading.value)
                              return TextButton(
                                style: ButtonStyle(
                                    shadowColor: MaterialStateProperty.all<Color>(myColors.coll),
                                    backgroundColor: MaterialStateProperty.all<Color>(myColors.coll),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14.0),
                                    ))),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    signUpFormController.updateUser();
                                  } else {
                                    print("not valid");
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 6.0, bottom: 6, left: 64, right: 64),
                                  child: Text(
                                    myStrings.edit,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              );
                            else {
                              return Center(
                                  child: CircularProgressIndicator(
                                color: myColors.coll,
                              ));
                            }
                          }),
                          SizedBox(
                            height: 32,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            IgnorePointer(
              child: Obx(() => AnimatedContainer(
                transform: Matrix4.translationValues(myDrawerController.xOffset.value, myDrawerController.yOffset.value * 1.5, 0)
                  ..scale(myDrawerController.scaleFactor.value),
                duration: Duration(milliseconds: 250),
                decoration: BoxDecoration(
                  // color: myDrawerController.backgroundColor.value,
                    borderRadius: BorderRadius.circular(myDrawerController.isDrawerOpen.value ? 0 : 0)),
              )),
            )
          ],
        ));
  }
}
