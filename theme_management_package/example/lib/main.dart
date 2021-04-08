import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:observing_stateful_widget/observing_stateful_widget.dart';
import 'package:theme_management_package/theme_management_package.dart';

import 'constants.dart' as K;

ThemeData get darkTheme {
  return ThemeData(
      primaryColor: K.lightGrey,
      scaffoldBackgroundColor: Colors.black,
      textTheme: ThemeData.dark().textTheme,
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        buttonColor: K.lightPurple,
      ));
}

final ThemeCubit themeCubit = ThemeCubit();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ThemeCubit.setup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeCubitState>(
      bloc: themeCubit,
      builder: (_, state) {
        ThemeMode themeMode = themeCubit.themeMode;
        if (state is UpdateThemeMode) {
          themeMode = state.themeMode;
        }
        return MaterialApp(
          title: 'Flutter Demo',
          theme: themeCubit.lightTheme,
          darkTheme: themeCubit.darkTheme,
          themeMode: themeMode,
          home: MyHomePage(title: 'Flutter Demo Home Page'),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ThemeIcons _themeIcons = DefaultThemeIcons();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20, top: 12),
            child: GestureDetector(
              onTap: () {},
              child: themeCubit.themeModeIcon(context),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Generic header',
            ),
            Text(
              'Text without context',
              style: Theme.of(context).textTheme.headline4,
            ),
            Test(),
            Row(
              children: [
                _themeIcons.applicationDark,
                _themeIcons.applicationLight,
                _themeIcons.platformDark,
                _themeIcons.platformLight,
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              themeCubit.setThemeMode(ThemeMode.dark);
            },
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: () {
              themeCubit.setThemeMode(ThemeMode.light);
            },
            tooltip: 'Increment',
            child: Icon(Icons.lightbulb),
          ),
        ],
      ),
    );
  }
}

class Test extends StatefulWidget {
  @override
  _Test createState() => _Test();
}

class _Test extends ObservingStatefulWidget<Test> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Text('SYSTEM', style: TextStyle(fontSize: 56.0)),
        onTap: () {
          themeCubit.setThemeMode(ThemeMode.system);
        });
  }
}
