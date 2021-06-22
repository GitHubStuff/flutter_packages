import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'cache_state.dart';

class CacheCubit extends Cubit<CacheState> {
  CacheCubit() : super(CacheInitial());

  void setViewText(String text) => emit(CacheSelected(text));
}
