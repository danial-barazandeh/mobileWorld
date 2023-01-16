import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jmob/Model/Device.dart';
import 'package:jmob/Model/Post.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:woocommerce/models/product_category.dart';

import '../Model/Brand.dart';


class PostWidget extends StatelessWidget {
  final Post post;

  const PostWidget(this.post);
  @override
  Widget build(BuildContext context) {
    // height: MediaQuery.of(context).size.height*0.15,
    // width: MediaQuery.of(context).size.height*0.15,
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: MediaQuery.of(context).size.height*0.18,
            width: MediaQuery.of(context).size.width*0.4,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: post.image!.toString(),
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
          ),
          ClipRRect(
            borderRadius: BorderRadius.only(bottomLeft:Radius.circular(16),bottomRight: Radius.circular(16)),
            child: Container(
              width: MediaQuery.of(context).size.width*0.4,
              color: Colors.white,
              height: MediaQuery.of(context).size.height*0.05,
              alignment: Alignment.center,
              child: Text(post.title.toString(),style: TextStyle(fontSize: 12),textAlign: TextAlign.center,)
            ),
          ),
        ],
      ),
    );
  }
}