import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:jmob/Pages/Home/Home.dart';
import 'package:jmob/Pages/Home/HomeBinding.dart';
import 'package:jmob/Pages/PostView/PostViewController.dart';
import 'package:jmob/Services/MyColors.dart';
import 'package:jmob/Services/MyStrings.dart';
import 'package:jmob/Widget/BottomNavigation/ButtomNavigation.dart';
import 'package:jmob/Widget/BrandWidget.dart';
import 'package:jmob/Widget/ProductWidget.dart';
import 'package:jmob/Widget/Slider/MainSlider.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:woocommerce/models/product_category.dart';
import 'package:woocommerce/models/product_tag.dart';

import '../../Model/Product.dart';
import '../../Widget/ProductWidgetMultilevel.dart';
import 'package:google_fonts/google_fonts.dart';

class PostView extends GetView<PostViewController> {
  @override
  Widget build(BuildContext context) {
    MyColors myColors = new MyColors();
    MyStrings myStrings = Get.find<MyStrings>();
    bool _pinned = true;
    bool _snap = false;
    bool _floating = false;
    return Scaffold(
      backgroundColor: myColors.background,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: _pinned,
            centerTitle: true,
            snap: _snap,
            floating: _floating,
            expandedHeight: 200.0,
            backgroundColor: myColors.primary,
            // backgroundColor: Colors.transparent.withAlpha(0),
            // shadowColor: Colors.transparent.withAlpha(0),


            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.only(left:12,bottom: 16,right: 12),
              // centerTitle: true,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                      controller.selectedPost.value.title,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),


              background: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: controller.selectedPost.value.image!.toString(),
                progressIndicatorBuilder: (context, url, downloadProgress) => Container(
                    child: SkeletonAnimation(
                  shimmerColor: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(20),
                  shimmerDuration: 2000,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(20),
                      // boxShadow: shadowList,
                    ),
                  ),
                )),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          ),

          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    child: Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(8),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: HtmlWidget(
                          controller.selectedPost.value.content,
                          customStylesBuilder: (element) {
                            if (element.classes.contains('foo')) {
                              return {'color': 'red'};
                            }

                            return null;
                          },
                          customWidgetBuilder: (element) {
                            if (element.attributes['foo'] == 'bar') {
                              return SizedBox();
                            }

                            return null;
                          },
                          onErrorBuilder: (context, element, error) => Text('$element error: $error'),
                          onLoadingBuilder: (context, element, loadingProgress) => CircularProgressIndicator(),
                          renderMode: RenderMode.column,
                          textStyle: TextStyle(fontSize: 14,color: myColors.textColor.withOpacity(0.7)),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ), //SliverChildBuildDelegate
          ) //SliverList
        ],
      ),
    );
  }
}
