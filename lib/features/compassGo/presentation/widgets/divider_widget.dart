import 'package:flutter/material.dart';

class DividerWidget extends StatelessWidget {

  final double indent;
  final double endIndet;
  final Color? color;
  final BorderRadiusGeometry radius;
  final double thickness;

  const DividerWidget({
    super.key,  
    required this.indent, 
    required this.endIndet, 
    this.color, 
    required this.radius, 
    required this.thickness
  });

  @override
  Widget build(BuildContext context) {
    return Divider(
      indent: indent,
      endIndent: endIndet,
      thickness: thickness,
      radius: radius,
      color: color ?? Colors.white60,
    );
  }
}