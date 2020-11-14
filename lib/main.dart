import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lookup/get_it.dart';
import 'package:lookup/views/search_bin_view.dart';

void main() { 
  getInit();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      title: 'Lookup',
      debugShowCheckedModeBanner: false,
      home: SearchBin(),
      theme: ThemeData(fontFamily: 'Roboto'),
      navigatorKey: getIt<NAVIGATOR>().navigateKey,
    );
  }
}