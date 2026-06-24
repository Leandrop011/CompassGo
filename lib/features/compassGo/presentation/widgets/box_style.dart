import 'package:flutter/material.dart';

// ! WIDGET DE ESTILO DE UN CONTAINER
class BoxStyle extends StatelessWidget {

  final Color color;
  final BorderRadius borderRadius;
  final Border border;
  final Widget child;
  final double height;

  const BoxStyle({
    super.key, 
    required this.color, 
    required this.borderRadius, 
    required this.border, 
    required this.child, 
    required this.height
  });

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsetsGeometry.only(top: size.height * 0.01, right: size.width * 0.01),
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: borderRadius,
          border: border,
        ),
        child: child,
      ),
    );
  }
}