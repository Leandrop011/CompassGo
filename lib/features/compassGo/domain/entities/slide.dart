
// ! ENTIDAD SLIDE
import 'package:flutter/material.dart';

class Slide {
  final String title;
  final String? subTitle;
  final IconData? icon;
  final Widget widget;
  final String? routeConfiguration;

  Slide({
    required this.title, 
    this.icon, 
    required this.widget, 
    this.subTitle, 
    this.routeConfiguration
  });
}