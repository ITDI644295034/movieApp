import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:miniprojectmovieapp/model/airing_model.dart';
import 'package:miniprojectmovieapp/model/keyword_model.dart';
import 'package:miniprojectmovieapp/model/toprate_model.dart';
import 'package:miniprojectmovieapp/model/vdo_model.dart';

import 'api.dart';

class ServiceNetwork {
  final dio = Dio();

  Future<AiringModel> getAiringDio() async {
    final response = await dio.get(API.TV_URL);
    if (response.statusCode == 200) {
      print(response.data);
      print('Airing');
      return airingModelFromJson(jsonEncode(response.data));
    }
    throw Exception('Network TV Failed');
  }


  Future<ToprateModel> getTopRateDio() async {
    final response = await dio.get(API.TOPRATE_URL);
    if (response.statusCode == 200) {
      print(response.data);
      print('Toprate');
      return toprateModelFromJson(jsonEncode(response.data));
    }
    throw Exception('Network TV Failed');
  }


  Future<KeywordModel> getKeywordDio(String id) async {
    final response = await dio.get(API.URLBASE + id + API.KEYWORD_URLKEY);
    if (response.statusCode == 200) {
      print(response.data);
      print(response.statusCode);
      print('อะไร');
      // return upcomingMovieModelFromJson(json.encode(response.data));
      return keywordModelFromJson(json.encode(response.data));
    }
    throw Exception('Network Keyword Failed');
  }

  Future<VideoModel> getClipDio(String id) async {
    final response = await dio.get(API.URLBASE + id + API.VDO_URL);
    if (response.statusCode == 200) {
      print(response.data);
      print(response.statusCode);
      print('55555555555555');
      // return upcomingMovieModelFromJson(json.encode(response.data));
      return videoModelFromJson(json.encode(response.data));
    }
    throw Exception('Network Keyword Failed');
  }

}
