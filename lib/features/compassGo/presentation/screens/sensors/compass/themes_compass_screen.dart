import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:compass_app/features/compassGo/presentation/widgets/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../../providers/providers.dart';

class ThemesCompass extends StatelessWidget {
  const ThemesCompass({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Temas Compass'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => ShowDialogWidget.showDialogAlert(
              context, 
              'Informacion', 
              'Esta pantalla permite seleccionar entre diferentes temas visuales para la brújula, personalizando su apariencia según las preferencias del usuario.', 
              [
                FilledButton(
                  onPressed: () => context.pop(), 
                  style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(10))
                  ),
                  child: const Text('Ok'),
                ),
              ],
            ), 
            icon: const Icon(Icons.info),
          ),
        ],
        leading: IconButton(onPressed: () => context.pop(), icon: const Icon(Icons.arrow_back_ios_new_rounded)),

      ),

      body: const _BodyView(),
    );
  }
}


class _BodyView extends ConsumerWidget {
  const _BodyView();

  @override
  Widget build(BuildContext context, ref) {

    final size = MediaQuery.of(context).size;
    final valueThemeProvider = ref.watch(themesCompassProvider).theme;
    final themesCompass = ref.watch(themesCompassProvider.notifier).themesCompass();
    final colorTheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: RadioGroup<ThemesCompassTypes>(
        // * THE VALUE THAT WILL MATCH A RADIO
        groupValue: valueThemeProvider,
        onChanged: ( ThemesCompassTypes? value) {
          ref.read(themesCompassProvider.notifier).changeTheme(value!.index, valueTheme: value);
          ref.read(themesCompassProvider.notifier).setValueThemeStorage(value.index);
        },
        // * MASONRY STYLE OF THE LIST
        child: MasonryGridView.count(
          physics: const BouncingScrollPhysics(),
          crossAxisCount: 2,
          itemCount: themesCompass.length,
          mainAxisSpacing: size.height * 0.01,
          crossAxisSpacing: size.width * 0.02,
          itemBuilder: (context, index){
        
            final theme = themesCompass[index];
            // ? A THEME
            return ZoomIn(
              child: GestureDetector(
                onTap: () async{
                  final value = await ref.read(themesCompassProvider.notifier).getValueThemeStorage();
                  ref.read(themesCompassProvider.notifier).changeTheme(value, valueTheme: theme.theme);
                  ref.read(themesCompassProvider.notifier).setValueThemeStorage(theme.theme.index);
        
                  HapticFeedback.mediumImpact();
                },
                child: CardRadioWidget(
                  size: size, 
                  theme: theme,
                  colorTheme: colorTheme,
                  valueThemeProvider: valueThemeProvider,
                  textTheme: textTheme,
                ),
              ),
            );
          },
        ),
      )
    );
  }
}