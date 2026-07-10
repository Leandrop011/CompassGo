# CompassGO
Una aplicacion de brujula digital, datos numericos de ubicacion
y grafico del mapa donde se encuntre el usuario.

# Descargas
Colocar un Splash Screen (Flutter native splash)
```
flutter pub add flutter_native_splash
dart run flutter_native_splash:create
```
Colocar un icon a la app (Flutter Launcher icons)
```
flutter pub add flutter_launcher_icons
dart run flutter_launcher_icons
dart run flutter_launcher_icons:generate
```
Permisos (Permissions Handler)
```
flutter pub add permission_handler
(Cambios necesarios en el Manifest)
```
Paquete Compass(Necesario para emititr valores de localizacion)
```
flutter pub add flutter_compass
```
Animaciones
```
flutter pub add lottie
```
Gurdar localmente datos
```
flutter pub add shared_preferences
```
Paquete para usar el map de google(requiere un proyecto en google cloud para su funcionamiento)
```
flutter pub add google_maps_flutter
flutter pub add geolocator
```
Environments
Colocar el API KEY de google cloud en el .env, renombrar el .env-exameple to .env
e instalar la siguiente extension
```
flutter pub add flutter_dotenv
```
Generar IDs aleatorios
```
dart pub add uuid
```
Usar los sensores del dispositivo
```
flutter pub add sensors_plus
```