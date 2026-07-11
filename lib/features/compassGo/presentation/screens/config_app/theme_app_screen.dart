import 'package:compass_app/config/config.dart';
import 'package:compass_app/features/compassGo/presentation/providers/providers.dart';
import 'package:compass_app/features/compassGo/presentation/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ThemeAppScreen extends StatelessWidget {
  const ThemeAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Temas App'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => context.pop(), 
          icon: const Icon(Icons.arrow_back_ios_new_rounded)
        ),
        actions: [
          IconButton(
            onPressed: () => ShowDialogWidget.showDialogAlert(
              context, 
              'Informacion', 
              'En esta seccion podras cambiar el tema de la aplicacion, el cual se aplicara en toda la app.', 
              [
                FilledButton(
                  onPressed: () => context.pop(),
                  style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(10))
                  ), 
                  child: const Text('Ok')
                )
              ]
            ), 
            icon: const Icon(CupertinoIcons.info_circle_fill)
          )
        ],
      ),


      body: const _BodyView(),
    );
  }
}

// ? widget que contruye la lista de temas
class _BodyView extends ConsumerWidget {
  const _BodyView();

  @override
  Widget build(BuildContext context, ref) {

    final themeValueState = ref.watch(themeValueProvider);
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    // ? lsitado de temas
    return ListView.builder(
      itemCount: listColorsThemeApp.length,
      itemBuilder: (context, index) {
        final itemColor = listColorsThemeApp[index];
    
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: size.height * 0.005, vertical: size.width * 0.01),
          child: BoxStyle(
            color: itemColor.$1.withOpacity(0.5), 
            borderRadius: BorderRadius.circular(15), 
            height: size.height * 0.1, 
            width: size.width * 0.9,
            boxShadow: [
              BoxShadow(
                color: itemColor.$1,
                blurRadius: 4,
                offset: const Offset(3, 2),
                spreadRadius: 1
              )
            ],
            child: RadioListTile(
              title: Text('Tema: ${itemColor.$2}', style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),),
              groupValue: index, // ? al tipo que pertenece
              value: themeValueState.valueTheme, // ? el value que esta seleccionado 
              onChanged: (_) { //? metodo que cambia el value
                ref.read(themeValueProvider.notifier).changeTheme(index);
                HapticFeedback.mediumImpact();
              },
            ),
          ),
        );
      },
    );
  }
}