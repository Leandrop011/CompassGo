import 'package:flutter_compass/flutter_compass.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ! STREAM PROVIDER QUE ESTARA EMITIENDO VALORES(grados) DE LA UBICACION DEL USER
// ! USAMOS FLUTTER COMPASS PARA ESO
final compassProvider = StreamProvider.autoDispose<double?>((ref) async*{
  
  // * CASO DE QUE NO TENGA ACCESO A LA UBICACION
  if (FlutterCompass.events == null) {
    throw Exception('Error, no hay acceso a la ubicacion');
  }

  // * LO MANEJAMOS CON UN TRY CATCH PORQUE PUEDE EXISTIR UN ERROR INESPERADO
  try {
    
    // * EMISION DE LOS VALORES
    await for (final event in FlutterCompass.events!) {
      yield event.heading!;
    }

  } catch (e) {
    throw Exception('Error getting heading: $e');
  }

});