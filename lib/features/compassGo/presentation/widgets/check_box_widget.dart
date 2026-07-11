import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ! WIDGET DE UN CHECKBOXLISTILE
class CheckBoxTile extends ConsumerWidget {

  final String title;
  final String subTitle;
  final IconData icon;
  final VoidCallback onChanged;
  final bool value;

  const CheckBoxTile({
    super.key,  
    required this.title, 
    required this.subTitle, 
    required this.icon, 
    required this.onChanged, 
    required this.value
  });

  @override
  Widget build(BuildContext context, ref) {
    final textTheme = Theme.of(context).textTheme;

    return CheckboxListTile(
      checkboxScaleFactor: 1.2,
      
      title: Text(title, style: textTheme.bodyLarge?.copyWith( color: Colors.white),),
      subtitle: Text(subTitle, style: textTheme.bodySmall?.copyWith(color: Colors.white),),
      secondary: Icon(icon, color: Colors.white,),

      value: value, 
      onChanged: (_) => onChanged(),
    );
  }
}