
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sensors_plus/sensors_plus.dart';

// ! STREAM QUE EMITE LOS VALORES DEL MAGNETOMETRO 
final magnetometerProvider = StreamProvider.autoDispose<MagnetometerXYZ>((ref) async*{
  
  // ? GRACIAS AL PAQUETE SENSORS PLUS USAMOS SU METODO Y EMITIMOS 
  // ? INSTANCIAS DE LA CLASE MAGNETOMETERXYZ
  await for (final event in magnetometerEventStream()) {
    // ? X Y Z DE CADA EMISION DEL METODO DE SENSORS PLUS
    final x = double.parse(event.x.toStringAsFixed(2));
    final y = double.parse(event.y.toStringAsFixed(2));
    final z = double.parse(event.z.toStringAsFixed(2));

    yield MagnetometerXYZ(x: x, y: y, z: z);
  }

});

// * CLASE QUE USAREMOS PARA LA EMISION DE LOS DATOS XYZ 
class MagnetometerXYZ {
  final double x;
  final double y;
  final double z;

  MagnetometerXYZ({
    required this.x, 
    required this.y, 
    required this.z
  });

}