part of 'theme_cubit.dart';

@immutable
abstract class ThemeCubitState {}

class ThemeCubitInitial extends ThemeCubitState {}

class UpdateThemeMode extends ThemeCubitState {
  final ThemeMode themeMode;
  UpdateThemeMode(this.themeMode);
}
