import 'package:compass_app/features/compassGo/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// ! WIDGET QUE CONSTRUYE EL MAP DE GOOGLE MAPS

class MapWidget extends ConsumerWidget {

  const MapWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {

    final themeMap = ref.watch(themesMapProvider).typeMap;
    final userLocation = ref.watch(userLocationProvider);

    return Center(
      // ? usamos el .when para poseer los 3 estados y al obtener 
      // ? la data y desestructurizar el record que nos da el future
      child: userLocation.when(
        data: (data) => _MapView(initialLat: data.$1, initialLng: data.$2, typeMap: themeMap,), 
        error: (error, stackTrace) => Text('Error: $error'), 
        loading: () => const CircularProgressIndicator(),
      ),
    );
  }
}

// * widget que dibuja el map
class _MapView extends ConsumerWidget {

  final double initialLat;
  final double initialLng;
  final MapType typeMap;

  const _MapView({
    required this.initialLat, 
    required this.initialLng, 
    required this.typeMap,
  });

  @override
  Widget build(BuildContext context, ref) {

  
    final controllerMap = ref.watch(mapControllerProvider);


    return ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(35),
      child: GoogleMap(

        markers: controllerMap.markersSet,

        mapType: typeMap, // * theme
        initialCameraPosition: CameraPosition(
          target: LatLng(initialLat, initialLng),  // * initial state of lng and lat
          zoom: 13.5,
        ),
        
        trafficEnabled: (typeMap.name == 'normal') ? true : false,

        myLocationEnabled: true, // * view your position in map
      
        // * init the controller googlemap
        onMapCreated: (GoogleMapController controller) { // * controller
          ref.read(mapControllerProvider.notifier).setMapController(controller);
        },

        // * if the user longpress, add a marker
        // * argument is the position
        onLongPress: (argument) {
          
          ref.read(mapControllerProvider.notifier).addMarker(argument.latitude, argument.longitude, 'Marker');

          ref.read(mapControllerProvider.notifier).cancelFollow();

          HapticFeedback.mediumImpact();

        },
      ),
    );
  }
}