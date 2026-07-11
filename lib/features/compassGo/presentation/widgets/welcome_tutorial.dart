import 'package:compass_app/features/compassGo/presentation/widgets/divider_widget.dart';
import 'package:compass_app/features/compassGo/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class WelcomeTutorial extends StatelessWidget {
  const WelcomeTutorial({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    return TutorialContentWidget(
      size: size, 
      imageSldie: 'assets/tutorial_app/welcome.png', 
      contentSlide: 'Bienvenido a CompassGo. \nTu brújula personal, con tu propio estilo. Explora, oriéntate y encuentra tu norte estés donde estés.', 
      textTheme: textTheme
    );
  }
}