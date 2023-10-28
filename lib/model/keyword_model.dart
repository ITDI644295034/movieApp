// To parse this JSON data, do
//
//     final keywordModel = keywordModelFromJson(jsonString);

import 'dart:convert';

KeywordModel keywordModelFromJson(String str) => KeywordModel.fromJson(json.decode(str));

String keywordModelToJson(KeywordModel data) => json.encode(data.toJson());

class KeywordModel {
  int? id;
  List<ResultKeyword>? results;

  KeywordModel({
    this.id,
    this.results,
  });

  factory KeywordModel.fromJson(Map<String, dynamic> json) => KeywordModel(
    id: json["id"],
    results: json["results"] == null ? [] : List<ResultKeyword>.from(json["results"]!.map((x) => ResultKeyword.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toJson())),
  };
}

class ResultKeyword {
  String? name;
  int? id;

  ResultKeyword({
    this.name,
    this.id,
  });

  factory ResultKeyword.fromJson(Map<String, dynamic> json) => ResultKeyword(
    name: json["name"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "id": id,
  };
}
