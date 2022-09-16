import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:woocommerce/models/product_category.dart';

import '../Model/Brand.dart';


class BrandWidgetPlaceHolder extends StatelessWidget {
  const BrandWidgetPlaceHolder();
  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(20),
        // boxShadow: shadowList,
      ),
      padding: EdgeInsets.all(3),
      height: MediaQuery.of(context).size.height*0.15,
      width: MediaQuery.of(context).size.height*0.15,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SkeletonAnimation(
          shimmerColor: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(20),
          shimmerDuration: 2000,
          child: Column(
            children: [

              Expanded(
                flex:3,
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                    // boxShadow: shadowList,
                  ),
                ),
              ),

              Expanded(
                flex:1,
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                    // boxShadow: shadowList,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}