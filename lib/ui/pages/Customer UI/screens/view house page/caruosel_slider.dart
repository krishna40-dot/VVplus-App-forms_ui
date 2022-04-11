import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:vvplus_app/ui/widgets/constants/assets.dart';

class ViewCarouselSlider extends StatelessWidget{
  const ViewCarouselSlider({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return CarouselSlider(
     //Carousel Slider
     items: [
       Container(
         margin: const EdgeInsets.all(5.0),
         decoration: BoxDecoration(
           borderRadius: BorderRadius.circular(8.0),
           image: const DecorationImage(
             image: AssetImage(image5),
             fit: BoxFit.fill,
           ),
         ),
       ),
       Container(
         margin: const EdgeInsets.all(5.0),
         decoration: BoxDecoration(
           borderRadius: BorderRadius.circular(8.0),
           image: const DecorationImage(
             image: AssetImage(image6),
             fit: BoxFit.fill,
           ),
         ),
       ),
       Container(
         margin: const EdgeInsets.all(5.0),
         decoration: BoxDecoration(
           borderRadius: BorderRadius.circular(8.0),
           image: const DecorationImage(
             image: AssetImage(image7),
             fit: BoxFit.fill,
           ),
         ),
       ),
       Container(
         margin: const EdgeInsets.all(5.0),
         decoration: BoxDecoration(
           borderRadius: BorderRadius.circular(8.0),
           image: const DecorationImage(
             image: AssetImage(image8),
             fit: BoxFit.fill,
           ),
         ),
       ),
     ],
     options: CarouselOptions(
       height: 250.0,
       enlargeCenterPage: true,
       autoPlay: true,
       autoPlayCurve: Curves.decelerate,
       enableInfiniteScroll: true,
       autoPlayAnimationDuration: const Duration(milliseconds: 1000),
       viewportFraction: 1.0,
     ),
   );
  }
  }

