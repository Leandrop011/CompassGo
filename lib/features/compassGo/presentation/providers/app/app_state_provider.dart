
import 'dart:ui';
import 'package:flutter_riverpod/legacy.dart';

// ! PROVIDER QUE NOS INFORMA EL STATE DE LA APP, RESUME/BACKGOUND/TERMINATED
final appStateProvider = StateProvider<AppLifecycleState>((ref) {
  
  return AppLifecycleState.resumed;

});