import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class AskPermissionWidget extends StatelessWidget {

  final String title;
  final String content;
  final VoidCallback onPressedPermission;

  const AskPermissionWidget({
    super.key, 
    required this.title, 
    required this.content, 
    required this.onPressedPermission,
  });

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    // final colorTheme = Theme.of(context).colorScheme;

    return Center(
      child: FadeInRight(
        child: Container(
          width: size.width * 0.8,
          height: size.height * 0.7,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color.fromARGB(255, 75, 82, 86)
          ),
        
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(title, style: textTheme.bodyLarge?.copyWith(fontSize: size.width * 0.06),),
              const SizedBox(height: 10,),
              Text(content, style:  textTheme.bodyMedium, textAlign: TextAlign.center,),
              const SizedBox(height: 10,),
              FilledButton.tonal(
                onPressed: () => onPressedPermission(),
                style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(10))
                ), 
                child: const Text('Permitir'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}