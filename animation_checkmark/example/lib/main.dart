import 'package:animation_checkmark/animation_checkmark.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  bool forward = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
            AnimatedCheckBox(
              animatedAction: forward ? AnimatedAction.draw : AnimatedAction.reset,
              containCheckMark: forward,
              sideLength: 48.0,
              animationDuration: Duration(seconds: 1),
              borderWidth: 2.0,
              checkmarkColor: Colors.green,
              boxColor: Colors.red,
              checkmarkStroke: 4.0,
              drawDelay: Duration(seconds: 1),
            ),
            AnimatedCheckBox(
              animatedAction: !forward ? AnimatedAction.draw : AnimatedAction.reset,
              containCheckMark: forward,
              sideLength: 48.0,
              animationDuration: Duration(seconds: 1),
              borderWidth: 2.0,
              checkmarkColor: Colors.green,
              boxColor: Colors.red,
              checkmarkStroke: 2.0,
              drawDelay: Duration(seconds: 2),
            ),
            AnimatedCheckMark(
              animatedAction: forward ? AnimatedAction.draw : AnimatedAction.reset,
              sideLength: 56.0,
              checkmarkColor: Colors.deepPurple,
              checkmarkStroke: 3.0,
            ),
            AnimatedCheckMark(
              animatedAction: forward ? AnimatedAction.draw : AnimatedAction.reset,
              sideLength: 56.0,
              checkmarkColor: null,
              checkmarkStroke: 4.0,
            ),
            AnimatedCheckCircle(
              animatedAction: forward ? AnimatedAction.draw : AnimatedAction.reset,
              containCheckMark: forward,
              sideLength: 56.0,
            ),
            AnimatedCheckCircle(
              animatedAction: forward ? AnimatedAction.draw : AnimatedAction.reset,
              containCheckMark: !forward,
              checkmarkColor: Colors.teal,
              circleColor: Colors.blueGrey,
              sideLength: 56.0,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            forward = !forward;
          });
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
