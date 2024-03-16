import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'page2.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var homePage;
    return MaterialApp(
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      routes: {
        '/pageTwo': (context) => PageTwo(
          institutions: homePage._institutions, 
          institutionImages: homePage._institutionImages,
          resetDataCallback: homePage._resetData, 
        ),
      },
    );
  }
}
