import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:time_toggle_buttons/source/cubit/toggle_cubit.dart';

import 'constants.dart' as K;

const double buttonSize = 48.0;

class TimeToggleButtons extends StatefulWidget {
  @override
  _TimeToggleButtonsState createState() => _TimeToggleButtonsState();
}

class _TimeToggleButtonsState extends State<TimeToggleButtons> {
  List<bool> _isSelected = [];

  Widget _template(String text) {
    return Container(
      color: K.background.of(context: context),
      child: Center(
          child: Padding(
              padding: EdgeInsets.only(left: 4, right: 4),
              child: Text(
                text,
                style: TextStyle(
                  color: K.textColors.of(context: context),
                ),
              ))),
      height: buttonSize,
      width: buttonSize,
    );
  }

  @override
  Widget build(BuildContext context) {
    ToggleCubit toggleCubit = Modular.get<ToggleCubit>();
    return BlocBuilder<ToggleCubit, ToggleState>(
        bloc: toggleCubit,
        builder: (contxt, state) {
          if (state is ToggleInitial) {
            _isSelected = state.states;
          }
          return ToggleButtons(
            isSelected: _isSelected,
            selectedColor: Colors.white,
            color: Colors.blueGrey,
            fillColor: Colors.lightBlue.shade900,
            borderWidth: 4,
            borderColor: Colors.lightBlue.shade900,
            selectedBorderColor: Colors.lightBlue,
            //borderRadius: BorderRadius.circular(50),
            children: <Widget>[
              _template('Years'),
              _template('Mths'),
              _template('Days'),
              _template('Hrs'),
              _template('Mins'),
              _template('Secs'),
            ],
            onPressed: (int newIndex) {
              toggleCubit.onSelected(newIndex);
            },
          );
        });
  }
}
