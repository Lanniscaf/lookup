import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';



final GetIt getIt =  GetIt.instance;


getInit() async {

  getIt.registerLazySingleton<NAVIGATOR>(() => NAVIGATOR());

}

class NAVIGATOR {
  final GlobalKey navigateKey= GlobalKey<NavigatorState>();
}
