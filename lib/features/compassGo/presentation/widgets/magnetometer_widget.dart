
import 'package:compass_app/features/compassGo/presentation/providers/providers.dart';
import 'package:compass_app/features/compassGo/presentation/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MagnetometerWidget extends ConsumerWidget {
  const MagnetometerWidget({super.key});

  @override
  Widget build(BuildContext context, ref) {

    final size = MediaQuery.of(context).size;
    final colorTheme = Theme.of(context).colorScheme;
    final magnetometerValues$ = ref.watch(magnetometerProvider);
    final textTheme = Theme.of(context).textTheme;

    return magnetometerValues$.when(
      data: (data) => _MagnetometerView(size: size, colorTheme: colorTheme, x: data.x, y: data.y, z: data.z, textTheme: textTheme,), 
      error: (error, stackTrace) => Text('Error: $error'), 
      loading: () => const Center(child: CircularProgressIndicator(strokeWidth: 5,),),
    );
  }
}

// * WIDGET QUE SE CONTRUYE CUANDO EXISTE DATA DEL MAGNETOMETRO
class _MagnetometerView extends StatelessWidget {

  final Size size;
  final ColorScheme colorTheme;
  final double x;
  final double y;
  final double z;
  final TextTheme textTheme;

  const _MagnetometerView({
    required this.size,
    required this.colorTheme, 
    required this.x, 
    required this.y, 
    required this.z, 
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        Icon(CupertinoIcons.dot_radiowaves_left_right, color: colorTheme.primary, size: size.width * 0.15,),
        
        SizedBox(height: size.height * 0.01,),
        
        BoxStyle(
          color: Colors.black, 
          borderRadius: BorderRadius.circular(10), 
          border: Border.all(width: 2, color: colorTheme.primary.withOpacity(0.7)), 
          height: size.height * 0.1, 
          width: size.width * 0.3, 
          child: Center(child: Text('Valores', style: textTheme.labelMedium?.copyWith(fontSize: size.width * 0.045, color: Colors.white),))
        ),
        
        SizedBox(height: size.height * 0.02,),
        
        DividerWidget(
          indent: size.width * 0.1, 
          endIndet: size.width * 0.1, 
          radius: BorderRadius.circular(10), 
          thickness: size.height * 0.004,
        ),

        SizedBox(height: size.height * 0.01,),

        BoxStyle(
          color: colorTheme.primary.withOpacity(0.2), 
          borderRadius: BorderRadius.circular(10), 
          border: Border.all(width: 2, color: Colors.white30), 
          height: size.height * 0.15, 
          width: size.width * 0.4, 
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('$x', style: textTheme.bodyMedium?.copyWith(fontSize: size.width * 0.045, color: Colors.white),),
              SizedBox(height: size.height * 0.01,),
              Text('$y', style: textTheme.bodyMedium?.copyWith(fontSize: size.width * 0.045, color: Colors.white),),
              SizedBox(height: size.height * 0.01,),
              Text('$z', style: textTheme.bodyMedium?.copyWith(fontSize: size.width * 0.045, color: Colors.white),),
            ],
          ),
        ),
      ],
    );
  }
}
