import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shopbiz/utils/constants.dart';

class CSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: caoursel.length,
      options: CarouselOptions(
        autoPlay: true,
        viewportFraction: 0.84,
        enlargeCenterPage: true,
        reverse: true,
      ),
      itemBuilder: (BuildContext context, int index, int page) {
        return Container(
          clipBehavior: Clip.antiAlias,
          decoration:
              BoxDecoration(
                borderRadius: BorderRadius.circular(20)),
          child: Stack(
            children: [
              Image(image:CachedNetworkImageProvider(
                caoursel[index].images,
              ) ),
              Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.black54.withOpacity(0.3),
                child: Center(
                  child: Text(
                    caoursel[index].text,
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
