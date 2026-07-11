import 'package:compass_app/features/compassGo/presentation/widgets/tutorial_content_widget.dart';
import 'package:flutter/material.dart';

class AboutTutorialWidget extends StatelessWidget {
  const AboutTutorialWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    return TutorialContentWidget(
      size: size, 
      imageSldie: 'assets/tutorial_app/about.png', 
      contentSlide: 'Todo lo que necesitas para orientarte. \nBrújula precisa, lectura en tiempo real y skins únicos para personalizar tu experiencia. Impulsada por los sensores de tu teléfono.', 
      textTheme: textTheme
    );
  }
}