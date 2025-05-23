import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../models/color_item.dart';
import 'package:google_fonts/google_fonts.dart';

class ColorCard extends StatelessWidget {
  final ColorItem item;
  final AudioPlayer audioPlayer = AudioPlayer();

  ColorCard({Key? key, required this.item}) : super(key: key);

  void _playSound() async {
    try {
      await audioPlayer.play(AssetSource(item.sound.replaceFirst('assets/', '')));
    } catch (e) {
      debugPrint('Error playing sound: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _playSound,
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: LinearGradient(
              colors: [Colors.white, item.color.withOpacity(0.7)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Color name
              Text(
                item.name,
                style: GoogleFonts.comfortaa(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: item.color == Colors.white ? Colors.black : Colors.white,
                  shadows: [
                    Shadow(
                      blurRadius: 2.0,
                      color: Colors.black.withOpacity(0.3),
                      offset: const Offset(1, 1),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Color block
              Expanded(
                flex: 2,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: item.color,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.grey.shade300,
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Image.asset(
                        item.image,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.image_not_supported, size: 64, color: Colors.white);
                        },
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Examples
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Text(
                      'Examples:',
                      style: GoogleFonts.comfortaa(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: item.color.withOpacity(0.8),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: item.examples.map((example) => 
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Chip(
                            label: Text(
                              example,
                              style: GoogleFonts.comfortaa(
                                fontSize: 12,
                                color: item.color == Colors.white ? Colors.black : item.color,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            backgroundColor: Colors.white,
                          ),
                        )
                      ).toList(),
                    ),
                  ],
                ),
              ),
              // Tap indicator
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.volume_up, color: Colors.black54),
                  const SizedBox(width: 4),
                  Text(
                    'Tap to hear',
                    style: GoogleFonts.comfortaa(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
} 