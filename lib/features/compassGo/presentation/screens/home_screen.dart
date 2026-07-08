import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:compass_app/features/compassGo/presentation/providers/providers.dart';
import 'package:compass_app/features/compassGo/presentation/widgets/widgets.dart';
import 'package:compass_app/features/compassGo/domain/domain.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    FlutterNativeSplash.remove(); 

    Future.delayed(
      const Duration(seconds: 1), 
      (){ 
        ref.read(permissionProvider.notifier).requestBothPermissions(); 
      }
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('CompassGO'),
    
        actions: [
          IconButton(
            onPressed: () => context.push('config-app-screen'), 
            icon: const Icon(Icons.settings_rounded)
          ),
          const SizedBox(width: 10,),
          IconButton(
            onPressed: () => context.push('info-app-screen'), 
            icon: const Icon(Icons.info_rounded)
          ),
        ],
    
      ),
    
      body: const _BodyView(),
    );
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
      Slide(title: 'Longitud - Latitud', widget: const Center()),
      Slide(title: 'Magnetometro', widget: const Center()),
    ];

    final size = MediaQuery.of(context).size;
    final colorTheme = Theme.of(context).colorScheme;

    return Column(
      children: [

        // * SLIDES
        Expanded(
          child: PageView(
            physics: const BouncingScrollPhysics(),
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
