import 'package:flutter/material.dart';

class FooterWidget extends StatelessWidget {

  final String nameApp;
  final String phrase;
  final String anio;
  final String version;
  final Size size;
  final Color colorText;
  final TextStyle textTheme;

  const FooterWidget({
    super.key, 
    required this.nameApp, 
    required this.phrase, 
    required this.anio, 
    required this.version, 
    required this.size, 
    required this.colorText, 
    required this.textTheme
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: size.height * 0.1,
      right: size.width * 0.5,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(nameApp, style: textTheme.copyWith(color: colorText),),
              // const SizedBox(width: 10,),
              Text(phrase, style: textTheme.copyWith(color: colorText),),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(anio, style: textTheme.copyWith(color: colorText),),
              // const SizedBox(width: 10,),
              Text(version, style: textTheme.copyWith(color: colorText),),
            ],
          ),

        ],
      )
    );
  }
}