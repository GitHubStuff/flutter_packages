import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'popover_state.dart';

class PopoverCubit extends Cubit<PopoverState> {
  PopoverCubit() : super(PopoverInitial());

  void showPopover() => emit(ShowPopover());

  void reset() => emit(RemovePopover());
}
