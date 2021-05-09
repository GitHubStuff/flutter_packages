# location_package

This package provides a BLoC design to get the user's location, store that location on-device for later
comparisons

## Getting Started

The example app has an implementation of the project. It uses MODULAR state managment, HIVE for
on-Device storage of location lat/long/time, and GEOLOCATOR to get the device posistion.

1) Add a 'ModuleRoute' to the main.dart AppModule

example:

```dart
class AppModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, __) => MyHomePage(title: 'Flutter Demo Home Page')),
        ModuleRoute('/location', module: LocationModule(locationWidget: LocationWidget())),
      ];
}
```

With a 'LocationWidget', the screen that is to be added to the app where access to the LocationState via the LocationCubit can process location events, saving/updating saved locations.

2) Within the *locationWidget* get the LocationCubit and within a BlocBuilder handle state changes as needed

```dart
LocationCubit.compareCurrentLocationAndSavedLocation({required String key});
LocationCubit.getCurrentLocation();
LocationCubit.getSavedLocation();
LocationCubit.saveLocation({required String key});
LocationCubit.setup()
```

*NOTE:* locationCubit.setup() must be called in LocationServiceStatus.initial to setup HIVE package

example:

```dart
Widget _body() {
    final LocationCubit locationCubit = Modular.get<LocationCubit>();
    return BlocBuilder<LocationCubit, LocationState>(
        bloc: locationCubit,
        builder: (context, state) {
          List<Widget> column = [];
          switch (state.locationServiceStatus) {
            case LocationServiceStatus.initial:
              locationCubit.setup();  //* Must be inital call to initialize HIVE package
              break;
               :
               :         
```


## Conclusion

### Be kind to each other
