import 'package:compass_app/features/compassGo/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class FinishTutorialWidget extends StatelessWidget {
  const FinishTutorialWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    return TutorialContentWidget(
      size: size, 
      imageSldie: 'assets/tutorial_app/finish.png', 
      contentSlide: 'Encuentra tu rumbo. \nYa conoces CompassGo. Ahora es tu turno: personaliza tu brújula y descubre a dónde te lleva.', 
      textTheme: textTheme
    );
  }
}