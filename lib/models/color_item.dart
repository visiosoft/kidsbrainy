import 'package:flutter/material.dart';

class ColorItem {
  final String name;
  final Color color;
  final String image;
  final String sound;
  final List<String> examples;

  ColorItem({
    required this.name,
    required this.color,
    required this.image,
    required this.sound,
    required this.examples,
  });
} 