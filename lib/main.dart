import 'package:flutter/material.dart';
import 'package:miniprojectmovieapp/app.dart';
import 'package:miniprojectmovieapp/provider/favorite_provider.dart';
import 'package:provider/provider.dart';

void main() {
  // runApp(const Myapp());
 runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavoriteProvider()),
      ],
      child: const Myapp(),
    ),
  );
}

