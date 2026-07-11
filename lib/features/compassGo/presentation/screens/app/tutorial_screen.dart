import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:flutter/services.dart';
import 'package:compass_app/features/compassGo/domain/domain.dart';
import 'package:compass_app/features/compassGo/presentation/providers/providers.dart';
import 'package:compass_app/features/compassGo/presentation/widgets/widgets.dart';

class TutorialScreen extends StatelessWidget {
  const TutorialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _BodyView(),
    );
  }
}

class _BodyView extends ConsumerStatefulWidget {
  const _BodyView();

  @override
  ConsumerState<_BodyView> createState() => _BodyViewState();
}

// ? LSIT DE TOTAL SLIDES PARA EL TUTORIAL
final List<Slide> tutorialSlides = [
  Slide(title: 'Bienvenido', widget: const WelcomeTutorial()),
  Slide(title: 'CompassGO', widget: const AboutTutorialWidget()),
  Slide(title: 'Comencemos', widget: const FinishTutorialWidget()),
];

class _BodyViewState extends ConsumerState<_BodyView> {
  final PageController pageController = PageController();
  bool showButtonGo = false;
  @override
  void initState() {
    super.initState();
    // ? si llega al ultimo slide cambia ed value la property showButtonGo to true
    pageController.addListener(
      () {
        // ? page en la que se encuentra by el controller
        final page = pageController.page ?? 0;

        // ? si la page en la que se encuentra, es mayor que el total de slides - 1.5 (casi el final)
        // ? cambia el valor de la property showButtonGo a true, sino lo cambia a false
        if (page >= tutorialSlides.length - 1.5) {
          setState(() {
            showButtonGo = true;
          });
        }else{
          setState(() {
            showButtonGo = false;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tutorialValueState = ref.watch(tutorialValueProvider);
    final colorTheme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Column(
        children: [
      
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FilledButton(
                onPressed: (){
                  ref.read(tutorialValueProvider.notifier).changeTutorialValue(!tutorialValueState.value);
                  HapticFeedback.mediumImpact();
                }, 
                style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(10)),
                ),
                child: const Text('Saltar')
              ),
            ),
          ),

          // ? slides and dots same controller
          Expanded(
            child: PageView(
              controller: pageController,
              children: tutorialSlides.map(
                (elemnt){
                  return SlideView(
                    title: elemnt.title, 
                    widget: elemnt.widget, 
                    size: size, 
                    routeConfiguration: '/'
                  );
                }
              ).toList(),
            ),
          ),

          Positioned(
            bottom: size.height * 0.14,
            left: size.width * 0.44,
            child: SmoothPageIndicator(
              controller: pageController, 
              count: tutorialSlides.length,
              axisDirection: Axis.horizontal,
              effect: ExpandingDotsEffect(
                dotHeight: 10,
                dotWidth: 10,

                radius: 3,
                activeDotColor: colorTheme.primary,
                dotColor: colorTheme.secondary,
              )
            ),
          ),
      
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: (showButtonGo) ? 
              FadeInRight(
                child: FilledButton(
                  onPressed: (){
                    ref.read(tutorialValueProvider.notifier).changeTutorialValue(!tutorialValueState.value);
                    HapticFeedback.mediumImpact();
                  }, 
                  style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(10)),
                  ),
                  child: const Text('Comenzar!')
                ),
              )
              :
              null,
            ),
          ),

          SizedBox(height: size.height * 0.02,)
      
        ],
      ),
    );
  }
}