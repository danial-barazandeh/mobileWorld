import 'dart:async';
import 'dart:io';

import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jmob/Model/User.dart';
import 'package:jmob/Pages/Home/Home.dart';
import 'package:jmob/Pages/Home/HomeBinding.dart';
import 'package:jmob/Pages/OrdersView/OrdersView.dart';
import 'package:jmob/Pages/OrdersView/OrdersViewController.dart';
import 'package:jmob/Pages/ProductView/ProductController.dart';
import 'package:jmob/Pages/SearchPage/SearchPage.dart';
import 'package:jmob/Pages/SignIn/SignInBinding.dart';
import 'package:jmob/Pages/SignUpForm/SignUpForm.dart';
import 'package:jmob/Services/BackendServices.dart';
import 'package:jmob/Services/MyColors.dart';
import 'package:jmob/Widget/BottomNavigation/ButtomNavigation.dart';
import 'package:loading_animations/loading_animations.dart';
import 'Pages/PartList/PartListController.dart';
import 'Pages/PhoneModelView/PhoneModelViewController.dart';
import 'Pages/SignIn/SignIn.dart';
import 'Pages/SignIn/SignInController.dart';
import 'Pages/SignUpForm/SignUpFormController.dart';
import 'Pages/VendorPage/VendorPageController.dart';
import 'Services/MyStrings.dart';
import 'Widget/BottomNavigation/ButtomNavigationController.dart';
import 'Widget/Drawer/MyPerfectDrawer.dart';
import 'Widget/Slider/MainSliderController.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // mame // description
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');
}

Future<void> main() async {
  Firebase auth;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // notifications
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  //notification

  await FirebaseAppCheck.instance.activate(
    webRecaptchaSiteKey: 'recaptcha-v3-site-key',
  );

  await FirebaseAppCheck.instance.getToken();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  var storage = GetStorage("userStorage");

  @override
  Widget build(BuildContext context) {
    Get.put(ProductController());
    Get.put(PartListController());
    Get.put(MyStrings());
    Get.put(SignUpFormController());
    Get.put(MyColors());
    Get.put(SignInController());
    Get.put(PhoneModelViewController());
    Get.put(MainSliderController());
    Get.put(BottomNavigationController());
    Get.put(VendorPageController());
    Get.put(OrdersViewController());
    Get.put(MyPerfectDrawer());


    return GetMaterialApp(
      localizationsDelegates: [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      routingCallback: (routing) {
        if (routing?.current == '/OrdersView') {
          OrdersViewController ordersViewController = Get.find<OrdersViewController>();
          if(!ordersViewController.isLoaded.value){
            ordersViewController.fetchOrder();
            final buttonNavigationController = Get.find<BottomNavigationController>();
            buttonNavigationController.selectOrders();
          }
        }else if (routing?.current == '/Home') {
          try{
            final myPerfectDrawer = Get.find<MyPerfectDrawer>();
            myPerfectDrawer.controller.selectHome();
            final buttonNavigationController = Get.find<BottomNavigationController>();
            buttonNavigationController.selectHome();
          }catch(e){
            print(e.toString());
          }
        }
        else if (routing?.current == '/SignUpForm') {
          try{
            final buttonNavigationController = Get.find<BottomNavigationController>();
            buttonNavigationController.selectSignUp();
          }catch(e){
            print(e.toString());
          }
        }
        else if (routing?.current == '/SearchPage') {
          try{
            final buttonNavigationController = Get.find<BottomNavigationController>();
            buttonNavigationController.selectSearch();
          }catch(e){
            print(e.toString());
          }
        }


      },
      getPages: [
        GetPage(
          name: '/OrdersView',
          page: () => OrdersView(),
        ),
        GetPage(
          name: '/Home',
          page: () => Home(),
        ),
        GetPage(
          name: '/SignUpForm',
          page: () => SignUpForm(),
        ),
        GetPage(
          name: '/SearchPage',
          page: () => SearchPage(),
        ),


      ],
      supportedLocales: [
        Locale("en", "US"), // OR Locale('ar', 'AE') OR Other RTL locales
      ],
      locale: Locale("en", "US"),
      // OR Locale('ar', 'AE') OR Other RTL locales,
      debugShowCheckedModeBanner: false,
      title: 'Jihani Mobile',
      theme: ThemeData(),
      home: MyHomePage(title: 'Jihani Mobile'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // user
  var storage = GetStorage("userStorage");
  var userList = <JmobUser>[];

  Future<String> getData() async {
    var data = await storage.read('user') ?? "empty";
    return data.toString();
  }

  Future<void> init() async {
    MyStrings myStrings = Get.find<MyStrings>();
    MyColors myColors = Get.find<MyColors>();
    //notification

    //notification

    await GetStorage.init("userStorage");
    String test = await getData();
    // print("okkkkkkkkk : " + test);
    var data = getData();
    Timer(Duration(seconds: 3), () async {
      if (test == "empty" || test.isEmpty) {
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: myColors.primary,
        ));
        Get.off(() => Home(), binding: HomeBinding());
      } else {
        try {
          SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
            statusBarColor: myColors.primary,
          ));
          final result = await InternetAddress.lookup('example.com');
          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
            var data = await storage.read('user') ?? "empty";
            JmobUser currentUser = JmobUser.fromJson(data);
            var updatedUser = await BackendServices.getUserInfo(currentUser.token);
            await storage.write('user', updatedUser!.toJson());
            SignUpFormController signUpFormController = Get.find<SignUpFormController>();
            signUpFormController.getUser();
            Get.off(() => Home(), binding: HomeBinding());
          }
        } on SocketException catch (_) {
          print("yeki pash rafte ro sim");
          Get.snackbar(
            myStrings.error,
            myStrings.internetError,
            icon: Icon(Icons.lock, color: Colors.white),
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.white,
            backgroundColor: myColors.coll.withAlpha(200),
          );
        }
      }
    });

    // Timer(Duration(seconds: 5),()=>Get.off(() => Home(), binding: HomeBinding()));
  }

  @override
  Widget build(BuildContext context) {
    init();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color.fromRGBO(25, 77, 112, 1),
    ));
    return Phoenix(
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment(0.8, 0.0), // 10% of the width, so there are ten blinds.
                colors: <Color>[Color.fromRGBO(25, 77, 112, 1), Color.fromRGBO(17, 48, 69, 1)], // repeats the gradient over the canvas
              ),
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent.withAlpha(0),
              elevation: 0.0,
            ),
            body: SafeArea(
              bottom: false,
              top: false,
              child: Align(
                alignment: Alignment(0, 0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 2,
                          child: Image.asset(
                            'images/Loading.png',
                            scale: 3,
                          )),
                      // Text(
                      //   "خوش آمدید",
                      //   textAlign: TextAlign.center,
                      //   style: TextStyle(
                      //     color: Colors.white38,
                      //     fontSize: 21,
                      //   ),
                      // ),
                    ],
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
