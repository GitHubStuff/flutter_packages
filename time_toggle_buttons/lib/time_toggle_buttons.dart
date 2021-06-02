library time_toggle_buttons;

import 'package:flutter/material.dart';

class TimeToggleButtons extends StatefulWidget {
  @override
  _TimeToggleButtonsState createState() => _TimeToggleButtonsState();
}

class _TimeToggleButtonsState extends State<TimeToggleButtons> {
  List<bool> isSelected = [true, true, true, true, true, true];

  Widget _template(String text) {
    return Container(
      child: Center(child: Padding(padding: EdgeInsets.only(left: 4, right: 4), child: Text(text))),
      height: 48,
      width: 48,
    );
  }

  @override
  Widget build(BuildContext context) => ToggleButtons(
        isSelected: isSelected,
        selectedColor: Colors.white,
        color: Colors.black,
        fillColor: Colors.lightBlue.shade900,
        borderWidth: 2,
        borderColor: Colors.lightBlue.shade900,
        selectedBorderColor: Colors.lightBlue,
        //borderRadius: BorderRadius.circular(50),
        children: <Widget>[
          _template('Yrs'),
          _template('Mths'),
          _template('Days'),
          _template('Hrs'),
          _template('Mins'),
          _template('Secs'),

          // Icon(Icons.ac_unit),
          // Icon(Icons.cake),
          // Icon(Icons.access_alarm),
          // Icon(Icons.hourglass_top),
          // Icon(Icons.margin_outlined),
          // Icon(Icons.security_rounded),
        ],
        onPressed: (int newIndex) {
          final isOneSelected = isSelected.where((element) => element).length == 1;

          if (isOneSelected && isSelected[newIndex]) return;

          setState(() {
            for (int index = 0; index < isSelected.length; index++) {
              if (index == newIndex) {
                isSelected[index] = !isSelected[index];
              }
            }
          });
        },
      );
}
