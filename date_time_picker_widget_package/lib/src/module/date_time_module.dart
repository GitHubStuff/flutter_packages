import 'package:date_time_picker_widget_package/src/cubit/date_time_cubit.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DateTimeModule extends Module {
  
  @override
  final List<Bind> binds = [Bind.lazySingleton((i) => DateTimeCubit(i.args?.data))];
}
