import 'package:flutter/material.dart';
import 'package:mobx_circleci/src/screens/review.screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Review() //previously MyHomePage(),
        );
  }
}
