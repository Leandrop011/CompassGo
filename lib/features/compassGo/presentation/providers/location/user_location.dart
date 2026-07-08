import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

// ! FUTURE PROVIDER QUE NOS DARA LOS DATOS DE LAT AND LNG
final userLocationProvider = FutureProvider.autoDispose<(double lat, double lng)>((ref) async {

  // * 1. PRIMERO VERIFICACION FUNCIONAMIENTO DEL SERVICIO 
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if(!serviceEnabled){
    return Future.error('Location services are diabled');
  }

  // * 2. VERIFICACION DE PERMISOS
  permission = await Geolocator.checkPermission();
  if( permission == LocationPermission.denied ){
    permission = await Geolocator.requestPermission();
    if( permission == LocationPermission.denied ){
      throw 'Location permissions are denied';
    }
  }

  if(permission == LocationPermission.deniedForever){
    throw 'Location permissions are permanently denied, we cannot request permissions.';
  }

  // * 3. OBTENER LOS DATOS, DESPUES DE LAS VERIFICACIONES Y RETORNARLOS
  final location = await Geolocator.getCurrentPosition();

  // ? a record
  return (location.latitude, location.longitude);
  
});