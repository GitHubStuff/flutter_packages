import 'package:bloc/bloc.dart';
import 'package:flutter_extras/flutter_extras.dart';
import 'package:meta/meta.dart';

part 'toggle_state.dart';

class ToggleButtonsCubit extends Cubit<ToggleState> {
  List<bool> isSelected = [true, true, true, true, true, true];

  ToggleButtonsCubit() : super(ToggleInitial([true, true, true, true, true, true]));

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

  Set<DateTimeElement> dateTimeElements() {
    final Set<DateTimeElement> result = {};
    if (isSelected[0]) result.add(DateTimeElement.year);
    if (isSelected[1]) result.add(DateTimeElement.month);
    if (isSelected[2]) result.add(DateTimeElement.day);
    if (isSelected[3]) result.add(DateTimeElement.hour);
    if (isSelected[4]) result.add(DateTimeElement.minute);
    if (isSelected[5]) result.add(DateTimeElement.second);
    return result;
  }
}
