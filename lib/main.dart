import 'package:autocompletado_app/home_Page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Autocompletado',
      home: HomePage()
    );
  }
}