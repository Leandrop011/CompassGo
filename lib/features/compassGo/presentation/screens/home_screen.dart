import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:compass_app/features/compassGo/presentation/presentation.dart';
import 'package:compass_app/features/compassGo/presentation/providers/providers.dart';
import 'package:compass_app/features/compassGo/presentation/widgets/widgets.dart';
import 'package:compass_app/features/compassGo/domain/domain.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    FlutterNativeSplash.remove(); 
    final size = MediaQuery.of(context).size;
    final colorTheme = Theme.of(context).colorScheme;
    final fountValueState = ref.watch(fountValueProvider);
    final tutorialValueState = ref.watch(tutorialValueProvider);

    Future.delayed(
      const Duration(seconds: 1), 
      (){ 
        ref.read(permissionProvider.notifier).requestBothPermissions(); 
      }
    );

    return (tutorialValueState.value) ? 
    Scaffold(
      appBar: AppBar(
        leadingWidth: size.width * 0.1, // ? max width leading widget
        
        leading: Row(
          children: [
            SizedBox(width: size.width * 0.03,),
            const Spacer(),
            BoxStyle(
              color: colorTheme.primary, 
              borderRadius: BorderRadius.circular(10), 
              height: size.height * 0.05, 
              width: size.width * 0.025,
            ),
          ],
        ),
        
        title: const Text('CompassGO'),
    
        actions: [
          IconButton(
            onPressed: () => context.push('config-app-screen'), 
            icon: const Icon(CupertinoIcons.gear_alt_fill)
          ),
          IconButton(
            onPressed: () => ref.read(fountValueProvider.notifier).changeFount(!fountValueState.fountValue), 
            icon: Icon( (fountValueState.fountValue) ? CupertinoIcons.sun_max : CupertinoIcons.moon_fill)
          ),
        ],
    
      ),
    
      body: const _BodyView(),
    )
    :
    const TutorialScreen();
  }
}

// * BODY DEL HOME
class _BodyView extends ConsumerStatefulWidget {

  const _BodyView();

  @override
  ConsumerState<_BodyView> createState() => _BodyViewState();
}

class _BodyViewState extends ConsumerState<_BodyView> {

  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {

    // * LISTA DE SLIDES QUE SE MOSTRARAN
    final List<Slide> slides = [
      Slide(title: 'Compass', widget: const CompassWidget(), routeConfiguration: 'config-theme-compass'),
      Slide(title: 'Mapa', widget: const MapWidget(), routeConfiguration: 'config-view-theme-map'),
      Slide(title: 'Longitud - Latitud', widget: const LonLatWidget()),
      Slide(title: 'Magnetometro', widget: const MagnetometerWidget()), 
    ];

    final size = MediaQuery.of(context).size;
    final colorTheme = Theme.of(context).colorScheme;

    return Column(
      children: [

        // * SLIDES
        Expanded(
          child: PageView(
            physics: const ClampingScrollPhysics(),
            controller: pageController,
            scrollDirection: Axis.horizontal,
            children: slides.map(
              (slide) => SlideView(
                title: slide.title, 
                widget: slide.widget,
                size: size,
                routeConfiguration: slide.routeConfiguration ?? '/',
              )
            ).toList(),
          ),
        ),
        
        // * DOTS( EL PAGE Y DOTS DEBEN TENER EL MISMO CONTROLLER )
        Positioned(
          bottom: size.height * 0.14,
          left: size.width * 0.44,
          child: SmoothPageIndicator(
            controller: pageController, 
            count: slides.length,
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

        SizedBox(height: size.height * 0.1,),
      ],
    );
  }
}
