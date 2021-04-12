// Copyright 2021, LTMM LLC
import 'package:flutter_modular/flutter_modular.dart';

import '../../src/cubit/date_time_cubit.dart';

class DateTimeModule extends Module {
  @override
  final List<Bind> binds = [Bind.lazySingleton((i) => DateTimeCubit(i.args?.data))];
}
