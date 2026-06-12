
// ! ENTIDAD SLIDE
import 'package:flutter/material.dart';

class Slide {
  final String title;
  final String? subTitle;
  final String image;
  final IconData? icon;
  final Widget widget;

  Slide({
    required this.title, 
    required this.image, 
    this.icon, 
    required this.widget, 
    this.subTitle
  });
}