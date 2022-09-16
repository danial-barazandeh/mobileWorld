import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:woocommerce/models/product_category.dart';

import '../Model/Brand.dart';


class BrandWidget extends StatelessWidget {
  final Brand brand;

  const BrandWidget(this.brand);
  @override
  Widget build(BuildContext context) {

    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height:8),
          Container(
            height: MediaQuery.of(context).size.height*0.07,
            width: MediaQuery.of(context).size.height*0.07,
            child: CachedNetworkImage(
              imageUrl: brand.image!.toString(),
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Container(
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
                    )
                  ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          SizedBox(height:8),
          Container(
            alignment: Alignment.center,
              child: Text(brand.name.toString(),style: TextStyle(fontSize: 12),)
          ),
          SizedBox(height:8),
        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
    );
  }
}