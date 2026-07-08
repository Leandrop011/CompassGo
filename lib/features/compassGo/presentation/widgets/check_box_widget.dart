
import 'package:flutter/material.dart';

// ! WIDGET DE UN CHECKBOXLISTILE
class CheckBoxTile extends StatelessWidget {

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
  Widget build(BuildContext context) {
    return CheckboxListTile(
      checkboxScaleFactor: 1.2,
      
      title: Text(title),
      subtitle: Text(subTitle),
      secondary: Icon(icon),

      value: value, 
      onChanged: (_) => onChanged(),
    );
  }
}