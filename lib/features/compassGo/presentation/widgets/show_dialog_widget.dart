import 'dart:ui';

import 'package:flutter/material.dart';

// ! WIDGET QUE CONSTRUYE UN ALERTDIALOG
class ShowDialogWidget {
  static void showDialogAlert( BuildContext context, String title, String content, List<Widget> actions, {ColorScheme? colorTheme} ) async{
    return showDialog(
      context: context, 
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0), // Intensidad del blur
          child: AlertDialog(
            backgroundColor: Colors.black54,
            title: Text(title),
            content: Text(content),
            actions: actions,
          ),
        ),
    );
  }  
}