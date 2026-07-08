import 'dart:async';

import 'package:flutter_riverpod/legacy.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();

// ! PROVIDER
final mapControllerProvider = StateNotifierProvider.autoDispose<MapControllerNotifier, MapControllerState>((ref) {
  return MapControllerNotifier();
});


// ! NOTIFIER
class MapControllerNotifier extends StateNotifier<MapControllerState> {
  MapControllerNotifier(): super(MapControllerState()){
    // ? escuhar al stream, miesntras se necesite el provider 
    trackUser().listen(
      (event) {
        lastLocation = (event.$1, event.$2);
      },
    );
  }

  // * RECORD QUE RECIBIRA NUEVOS DATOS CONSTANTEMENTE
  (double, double)? lastLocation;
  // * STREAM SUBSCRIPTION TO FOLLOW USER
  StreamSubscription? userLocation$;

  // * STREM QUE EMITIRA VALORES DE LA POSICION DEL USER CONSTANTEMENTE, MIENTRAS SE USA EL PROVIDER
  Stream<(double, double)> trackUser() async*{
    await for(final pos in Geolocator.getPositionStream()){
      yield (pos.latitude, pos.longitude);
    }
  }

  // * METODO QUE ESTABLECE UN CONTROLLER
  void setMapController( GoogleMapController controller ){
    state = state.copyWith(
      controller: controller,
      isReady: true,
    );
  }

  // * METODO QUE MUEVE LA CAMERA CON EL CONTROLLER GRACIAS A UNA NUEVA POSTION
  void goToLocationUser( double lat, double lng ){

    // * nueva posicion segun lo que nos entregue el provider
    final newPosition = CameraPosition(
      target: LatLng(lat, lng),
      zoom: 15,
    );

    // * cambiamos el value de la postion of the camera, con el controller,
    // * agregamos la nueva posicion
    state.controller?.animateCamera(
      CameraUpdate.newCameraPosition(newPosition),
    );
  }

  // * METODO QUE MUEVE LA CAMARA A LA UBICACION ACTUAL DEL USER, DESPUES DE LA RECEPCION DE DATOS DEL STREAM
  void findUser() async{
    if(lastLocation == null) return;
    goToLocationUser(lastLocation!.$1, lastLocation!.$2);

  }

  // * METODO QUE SIGUE AL USER EN CADA EMICION DE NUEVA POS ACTUAL
  void toggleFolowUser(){
    
    state = state.copyWith(
      followUser: !state.followUser
    );

    if (state.followUser) {
      // ? encontrar al user en la ubicacion actual
      findUser();

      // ? escuchar constantemente las emisiones de las nuevas pos, subscribirse al stream
      // ? y siempre estar escuchando las emisiones
      // ? y mover la camara a la nueva posicion en cada emision
      userLocation$ = trackUser().listen(
        (event) {
          goToLocationUser(event.$1, event.$2);
        },
      );
      
    }else{
      cancelFollow(); // ? in case false, cancel subscription to the stream
    }
  }

  // * METODO QUE CANCELA EL SEGUIMIENTO DE LA UBICACION DEL USER
  void cancelFollow(){
    state = state.copyWith(
      followUser: false,
    );

    userLocation$?.cancel(); // ? cancela la subscripcion y no hace nada
  }


  // * METODO QUE AGREGAR UN MARCKER AL MAPA DE LA ULTIMA UBICACION REGISTRADA(del user)
  void addMarkerCurrentPosition(String name){
    if(lastLocation == null) return;

    goToLocationUser(lastLocation!.$1, lastLocation!.$2);
    
    addMarker(lastLocation!.$1, lastLocation!.$2, name);
  }


  // * METODO QUE AGREGAR UN MARKER EN EL MAPA SEGUN LA POSITION OBTENIDA
  void addMarker( double lat, double lng, String name ){

    final newMarker = Marker(
      markerId:  MarkerId(_uuid.v4()),
      position: LatLng(lat, lng),
      infoWindow: InfoWindow( title: name, snippet: 'Marker number: ${state.markers.length + 1}' ) 
    );


    state = state.copyWith(
      markers: [...state.markers, newMarker],
    );

  }
  
}


// ! STATE
class MapControllerState {
  final bool isReady;
  final bool followUser;
  final List<Marker> markers;
  final GoogleMapController? controller;

  MapControllerState({
    this.isReady = false, 
    this.followUser = false, 
    this.markers = const [], 
    this.controller, 
  });

  // ? DARLE LOS MARKERS A EL WIDGET DEL MAP
  Set<Marker> get markersSet{
    return Set.from(markers);
  }


  MapControllerState copyWith({
    bool? isReady,
    bool? followUser,
    List<Marker>? markers,
    GoogleMapController? controller,
  }) => MapControllerState(
      isReady: isReady ?? this.isReady,
      followUser: followUser ?? this.followUser,
      markers: markers ?? this.markers,
      controller: controller ?? this.controller,
  );

}
