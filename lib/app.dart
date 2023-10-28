import 'package:flutter/material.dart';
import 'package:miniprojectmovieapp/screen/homescreen/homescreen.dart';

import 'config/approute.dart';

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: AppRoute().routeAll,
      home: HomeScreen(),
    );
  }
}
