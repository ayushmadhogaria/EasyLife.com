import 'package:carousel_slider/carousel_slider.dart';
import 'package:easylifeapp/constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CarousalImage extends StatefulWidget {
  const CarousalImage({super.key});

  @override
  State<CarousalImage> createState() => _CarousalImageState();
}

class _CarousalImageState extends State<CarousalImage> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> imageSliders = GlobalVariables.carouselImages
        .map((item) => Stack(
              children: [
                Image.network(
                  item,
                  fit: BoxFit.cover,
                  width: 1000.h,
                ),
              ],
            ))
        .toList();

    return Column(
      children: [
        CarouselSlider(
          items: imageSliders,
          options: CarouselOptions(
              viewportFraction: 1,
              autoPlay: true,
              height: 200.h,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: GlobalVariables.carouselImages.map((url) {
            int index = GlobalVariables.carouselImages.indexOf(url);
            return Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 3,
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _current == index
                    ? Color.fromARGB(255, 38, 100, 73)
                    : GlobalVariables.selectednavbarcolor,
              ),
            );
          }).toList(),
        )
      ],
    );
  }
}
