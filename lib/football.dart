import 'dart:convert';

import 'package:flutter/material.dart';

class Match {
  Match({
    required this.team1,
    required this.team2,
    required this.url,
    required this.image1,
    required this.image2,
  });

  String team1;
  String team2;
  String url;
  String image1;
  String image2;

  factory Match.fromJson(Map<String, dynamic> json) {
    return Match(
      team1: json['Team_1'],
      team2: json['Team_2'],
      url: json['url'],
      image1: json['image_1'],
      image2: json['image_2']
    );
  }

  Map<String, dynamic> toJson() => {
        'Team_1': team1,
        'Team_2': team2,
        'url': url,
        'image1':image1,
        'image2':image2,
      };

  static String encodeUser(Match model) => json.encode(model.toJson());

  static Match decodeUser(dynamic jsonString) {
    Map<String, dynamic> u = json.decode(jsonString);
    return Match.fromJson(u);
  }
}

class League {
  League({
    required this.title,
    required this.matches,
  });

  String title;
  List<Match> matches;

  factory League.fromJson(Map<String, dynamic> json) {
    return League(
      title: json['title'],
      matches: (json['matches'] != null)
          ? (json['matches'] as List).map((e) => Match.fromJson(e)).toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'matches': matches,
      };

  static String encodeUser(League model) => json.encode(model.toJson());

  static League decodeUser(dynamic jsonString) {
    Map<String, dynamic> u = json.decode(jsonString);
    return League.fromJson(u);
  }
}

class Football {
  Football({required this.league});

  List<League> league;

  factory Football.fromJson(Map<String, dynamic> json) {
    return Football(
      league: (json['league'] != null)
          ? (json['league'] as List).map((e) => League.fromJson(e)).toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() => {
        'league': league,
      };

  static String encodeUser(League model) => json.encode(model.toJson());

  static Football decodeUser(dynamic jsonString) {
    Map<String, dynamic> u = json.decode(jsonString);
    return Football.fromJson(u);
  }
}
