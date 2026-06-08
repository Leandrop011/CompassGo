
import 'package:flutter/material.dart';

class Permission {
  
  final String title;
  final String subTitle;
  final bool value;
  final VoidCallback onChanged;
  final IconData icon;

  Permission({
    required this.title, 
    required this.subTitle, 
    required this.value, 
    required this.onChanged, 
    required this.icon
  });

}