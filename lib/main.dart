import 'package:flutter/material.dart';
import 'package:lookup/get_it.dart';
import 'package:lookup/views/search_bin.dart';

void main() { 
  getInit();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lookup',
      debugShowCheckedModeBanner: false,
      home: SearchBin(),
      theme: ThemeData.light(),
      navigatorKey: getIt<NAVIGATOR>().navigateKey,
    );
  }
}