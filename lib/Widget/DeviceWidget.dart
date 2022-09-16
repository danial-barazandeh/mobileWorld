import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jmob/Model/Device.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:woocommerce/models/product_category.dart';

import '../Model/Brand.dart';


class DeviceWidget extends StatelessWidget {
  final Device device;

  const DeviceWidget(this.device);
  @override
  Widget build(BuildContext context) {

    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height:8),
          Container(
            height: MediaQuery.of(context).size.height*0.15,
            width: MediaQuery.of(context).size.height*0.15,
            child: CachedNetworkImage(
              imageUrl: device.image!.toString(),
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
              child: Text(device.name.toString())
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