import 'package:flutter/cupertino.dart';
import 'package:miniprojectmovieapp/screen/detail_page.dart';
import 'package:miniprojectmovieapp/screen/detail_toprate.dart';
import 'package:miniprojectmovieapp/screen/homescreen/homescreen.dart';
import 'package:miniprojectmovieapp/screen/vdo_page.dart';

class AppRoute {
  static const homeRoute = 'home';
  static const detailRoute = 'detail';
  static const detailTopRoute = 'detailTop';
  static const vdoRoute = 'vdoTop';
  final _route = <String, WidgetBuilder>{
    homeRoute: (context) => HomeScreen(),
    detailTopRoute: (context) => DetailTopRate(),
    detailRoute: (context) => DetailPage(),
    vdoRoute: (context) => VdoPage(),
  };

  get routeAll => _route;
}
