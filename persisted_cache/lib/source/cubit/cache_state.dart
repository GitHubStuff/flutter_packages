part of 'cache_cubit.dart';

@immutable
abstract class CacheState {}

class CacheInitial extends CacheState {}

class CacheSelected extends CacheState {
  final String cacheString;
  CacheSelected(this.cacheString);
}
