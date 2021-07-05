import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'toggle_state.dart';

class ToggleCubit extends Cubit<ToggleState> {
  List<bool> isSelected = [true, true, true, true, true, true];

  ToggleCubit() : super(ToggleInitial([true, true, true, true, true, true]));

  void onSelected(int index) {
    final isOneSelected = isSelected.where((element) => element).length == 1;
    if (isOneSelected && isSelected[index]) return;
    for (int listIndex = 0; listIndex < isSelected.length; listIndex++) {
      if (index == listIndex) {
        isSelected[listIndex] = !isSelected[listIndex];
      }
    }
    emit(ToggleInitial(isSelected));
  }
}
