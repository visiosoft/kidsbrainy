import 'package:flutter/material.dart';

class CountryItem {
  final String name;
  final String capital;
  final String flag;
  final String map;
  final String sound;
  final List<String> facts;
  final String continent;

  CountryItem({
    required this.name,
    required this.capital,
    required this.flag,
    required this.map,
    required this.sound,
    required this.facts,
    required this.continent,
  });
} 