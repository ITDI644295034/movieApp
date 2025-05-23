import 'package:flutter/material.dart';

import '../model/airing_model.dart';

class FavoriteProvider extends ChangeNotifier {
  List<Result> _favoriteList = [];

  List<Result> get favoriteList => _favoriteList;

  void addToFavorites(Result movie) {
    if (!_favoriteList.contains(movie)) {
      _favoriteList.add(movie);
      notifyListeners();
    }
  }

  void removeFromFavorites(Result movie) {
    if (_favoriteList.contains(movie)) {
      _favoriteList.remove(movie);
      notifyListeners();
    }
  }

  bool isFavorite(String movieId) {
    return _favoriteList.any((item) => item.id.toString() == movieId);
  }

}