// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter_riverpod/legacy.dart';
import 'package:permission_handler/permission_handler.dart';

final permissionProvider = StateNotifierProvider<PermissionNotifier, PermissionState>((ref) {
  return PermissionNotifier();
});

class PermissionNotifier extends StateNotifier<PermissionState> {
  PermissionNotifier(): super(PermissionState());

  // ! METODO QUE INICIALIZA EL ESTADO DE CADA PERMISO(NECESARIO AL INICIAL LA APP)
  void checkPermissions() async{
    // * ESPERAMOS POR SU RESPUESTA
    final permissionArray = await Future.wait([
      Permission.location.status,
      Permission.sensors.status,
    ]);
    
    state = state.copyWith(
      location: permissionArray[0],
      sensors: permissionArray[1],
    );
  }

  // ! METODO PRIVADO QUE ABRE LAS SETTINGS
  void _openSettingsScreen(){
    openAppSettings();
  }

  // ! METODO QUE VERIFICA EL STATUS DEL PERMISO, SI EL USER DENIEGA - ABRE LAS SETTINGS
  void _checkPermissionsState( PermissionStatus status ) async{
    if (status == PermissionStatus.permanentlyDenied) {
      _openSettingsScreen();
    }
  }
  
  // ! PERMISOS
  void requestPermissionSensors() async{
    final status = await Permission.sensors.request();

    state = state.copyWith(
      sensors: status
    );

    _checkPermissionsState(status);
  }

  void requestPermissionLocation() async{
    final status = await Permission.location.request();

    state = state.copyWith(
      location: status,
    );

    _checkPermissionsState(status);
  }
  
  // ! METODO QUE VERIFICA AMBOS STATUS 
  void _checkBothPermissionsState ( PermissionStatus statusLocation, PermissionStatus statusSensors ){
    if (statusLocation == PermissionStatus.permanentlyDenied || statusSensors == PermissionStatus.permanentlyDenied) {
      _openSettingsScreen();
    }
  }

  // ! METODO QUE REALIZA LA REQUEST DE LOS PERMISOS EN LA MISMA EJECUCION DEL METODO
  void requestBothPermissions() async{
    final statusLocation = await Permission.location.request();
    final statusSensors = await Permission.sensors.request();

    state = state.copyWith(
      location: statusLocation,
      sensors: statusSensors,
    );

    _checkBothPermissionsState(statusLocation, statusSensors);
  }

}

class PermissionState {
    final PermissionStatus sensors;
    final PermissionStatus location;
    final PermissionStatus locationAlways;
    final PermissionStatus locationWhenInUse;

  PermissionState({
    this.sensors =            PermissionStatus.denied, 
    this.location =           PermissionStatus.denied, 
    this.locationAlways =     PermissionStatus.denied, 
    this.locationWhenInUse =  PermissionStatus.denied
  });

  
  // ? PARA SABER SI YA FUERON OTORGADOS O NO
  bool get sensorsGranted{
    return sensors == PermissionStatus.granted;
  }

  bool get locationGranted {
    return location == PermissionStatus.granted;
  }

  bool get locationAlwaysGranted {
    return locationAlways == PermissionStatus.granted;
  }

  bool get locationWhenInUseGranted {
    return locationWhenInUse == PermissionStatus.granted;
  } 


  PermissionState copyWith({
    PermissionStatus? sensors,
    PermissionStatus? location,
    PermissionStatus? locationAlways,
    PermissionStatus? locationWhenInUse,
  }) => PermissionState(
      sensors:           sensors ?? this.sensors,
      location:          location ?? this.location,
      locationAlways:    locationAlways ?? this.locationAlways,
      locationWhenInUse: locationWhenInUse ?? this.locationWhenInUse,
  );
}
