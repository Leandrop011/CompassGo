import 'package:compass_app/domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    FlutterNativeSplash.remove();

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Text('Home Screen'),
            SizedBox(width: 10,),
            Icon(Icons.explore_rounded)
          ],
        ),

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
      // TODO: IMPLEMENTAR VERIFICACION SI LOS PERMISOS NO ESTAN OTORGADOS
      body: const _BodyView(),
    );
  }
}

final List<Slide> slides = [
  Slide(title: 'Compass', image: '', widget: const Center()),
  Slide(title: 'Mapa', image: '', widget: const Center()),
  Slide(title: 'Longitud - Latitud', image: '', widget: const Center()),
  Slide(title: 'Magnetometro', image: '', widget: const Center()),
];

class _BodyView extends StatefulWidget {
  const _BodyView();

  @override
  State<_BodyView> createState() => _BodyViewState();
}

class _BodyViewState extends State<_BodyView> {

  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final colorTheme = Theme.of(context).colorScheme;

    return Column(
      children: [

        Expanded(
          child: PageView(
            physics: const BouncingScrollPhysics(),
            controller: pageController,
            scrollDirection: Axis.horizontal,
          
            children: slides.map(
              (slide) => _SlideView(
                title: slide.title, 
                widget: slide.widget,
                size: size,
              )
            ).toList(),
          ),
        ),
        
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

class _SlideView extends StatelessWidget {

  final String title;
  final Widget widget;
  final String? subTitle;
  final IconData? icons;
  final Size size;


  const _SlideView({ 
    required this.title, 
    required this.widget, 
    this.subTitle, 
    this.icons, 
    required this.size, 
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Text(
            title, 
            style: textTheme.bodyMedium?.copyWith(fontSize: size.width * 0.06),
          ),

          const SizedBox(height: 10,),

          Container(
            width: size.width * 0.7,
            height: size.height * 0.6,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(20)
            ),
          ),  
        ],
      ),
    );
  }
}