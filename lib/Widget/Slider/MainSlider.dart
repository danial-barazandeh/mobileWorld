import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jmob/Services/MyColors.dart';
import 'package:jmob/Widget/Slider/MainSliderController.dart';
import 'package:skeleton_text/skeleton_text.dart';

class MainSlider extends GetView<MainSliderController> {
  MainSliderController mainSliderController = Get.find<MainSliderController>();

  final myColors = Get.find<MyColors>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (mainSliderController.imgList.length < 1)
        return SizedBox(
          height: 0,
        );

      if (mainSliderController.imgList.length > 0)
        return Container(
          height: MediaQuery.of(context).size.height*0.25,
            padding: EdgeInsets.only(left:8,right: 8),
            child: Swiper(
              outer:false,
              pagination: SwiperPagination(
                  margin: EdgeInsets.all(5.0)
              ),
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: mainSliderController.imgList[index],
                  ),
                );
              },
              itemCount: mainSliderController.imgList.length,
            ),
        );
      else
        return SizedBox(
          height: 0,
        );
    });

  }
}
