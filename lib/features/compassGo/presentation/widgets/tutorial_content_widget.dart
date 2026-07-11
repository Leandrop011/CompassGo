import 'package:flutter/material.dart';

import 'widgets.dart';

class TutorialContentWidget extends StatelessWidget {
  final Size size;
  final String imageSldie;
  final String contentSlide;
  final TextTheme textTheme;

  const TutorialContentWidget({
    super.key, 
    required this.size, 
    required this.imageSldie, 
    required this.contentSlide, 
    required this.textTheme
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size.width * 0.7,
          height: size.height * 0.2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10)
          ),
          child: ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(10),
            child: Image.asset(
              imageSldie,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: size.height * 0.025,),
        DividerWidget(
          indent: size.width * 0.08, 
          endIndet: size.width * 0.08, 
          radius: BorderRadiusGeometry.circular(10), 
          thickness: size.height * 0.008
        ),
        SizedBox(height: size.height * 0.025,),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
          child: Text(
            contentSlide,
            style: textTheme.bodyMedium?.copyWith(color: Colors.white),
          ),
        ),
      ],
    );
  }
}