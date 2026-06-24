import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../domain/domain.dart';
import '../providers/providers.dart';

// ! WIDGET DE UNA CARD CON UN RADIO
class CardRadioWidget extends StatelessWidget {

  final Size size;
  final ThemeCard theme;
  final ColorScheme colorTheme;
  final ThemesCompassTypes valueThemeProvider;
  final TextTheme textTheme;

  const CardRadioWidget({
    super.key, 
    required this.size, 
    required this.theme, 
    required this.colorTheme, 
    required this.valueThemeProvider, 
    required this.textTheme
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      width: size.width * 0.5,
      height: size.height * 0.3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.black,
        border: Border.all(color: (theme.theme.index == valueThemeProvider.index) ?
        colorTheme.primary.withOpacity(0.6)
        : 
        const Color.fromARGB(137, 189, 183, 183), width: size.width * 0.005),
        // * if the index of the theme is equals to the valuetheme from provider, drawer a boxshadow
        boxShadow: (valueThemeProvider.index == theme.theme.index) ?
        [
          BoxShadow(
            blurRadius: 15,
            spreadRadius: 0.1, 
            blurStyle: BlurStyle.normal,
            color: colorTheme.primary,
            offset: const Offset(1, 4),
          )
        ] 
        : 
        null
        
      ),
                        
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          
          // * TITLE AND RADIO
          CupertinoListTile(
            title: Text(
              theme.title, 
              style: textTheme.titleSmall?.copyWith( 
                fontSize: size.width * 0.04, 
                color: (theme.theme.index == valueThemeProvider.index) ? 
                  colorTheme.primary 
                  : 
                  Colors.white70
              ),
            ),
            leading: Radio(
              activeColor: colorTheme.primary,
              value: theme.theme,
            ),
          ),
          
          // * Compass images 
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  width: size.width * 0.6,
                  height: size.height * 0.6,
                  theme.imageQuadrant
                ),
                Image.asset(
                  width: size.width * 0.15,
                  height: size.height * 0.15,
                  theme.imageNeedle
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}