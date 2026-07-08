import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ! WIDGET QUE CONSTRUYE UN FILLED BUTTON
class FilledButtonWidget extends ConsumerWidget {

  final String label;
  final IconData icon;
  final Function onPressed;

  const FilledButtonWidget({
    super.key, 
    required this.label, 
    required this.onPressed, 
    required this.icon
  });

  @override
  Widget build(BuildContext context, ref) {

    final colorTheme = Theme.of(context).colorScheme;

    return FilledButton.icon(
      style: FilledButton.styleFrom(
        side: const BorderSide(width: 0.5, color: Colors.grey),
        shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(10)),
        backgroundColor: colorTheme.primary.withOpacity(0.8)
      ),
      onPressed: () => onPressed(),  // * funtion
      icon: Icon(icon),
      label: Text(label),
    );
  }
}