import 'package:flutter/material.dart';
import 'package:lookup/views/home_view.dart';
void main() { 
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lookup',
      debugShowCheckedModeBanner: false,
      home: HomeView(),
      theme: ThemeData.light(),
    );
  }
}