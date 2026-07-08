import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

// ! STREAM QUE NOS EMITIRA VALORES CONSTANTEMENTE DE LA LONG AND LAT
final watchLocationProvider = StreamProvider.autoDispose<(double lat, double lng)>((ref) async*{
  
  // * VALIDACIONES
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    throw 'The map services are diabled.';
  }

  permission = await Geolocator.checkPermission();
  if(permission == LocationPermission.denied){
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      throw 'Location Permissions are denied';
    }
  }

  if (permission == LocationPermission.deniedForever) {
    throw 'Location permissions are permanently denied, we cannot request permissions.';
  }

  // * EMICION DE DATOS
  await for (final pos in Geolocator.getPositionStream()) {
    yield (pos.latitude, pos.longitude);
  }

});