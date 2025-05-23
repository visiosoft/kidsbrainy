import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../models/number_item.dart';
import 'package:google_fonts/google_fonts.dart';

class NumberCard extends StatelessWidget {
  final NumberItem item;
  final AudioPlayer audioPlayer = AudioPlayer();

  NumberCard({Key? key, required this.item}) : super(key: key);

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
              colors: [Colors.green.shade200, Colors.teal.shade100],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Number and word
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      item.number.toString(),
                      style: GoogleFonts.comfortaa(
                        fontSize: 72,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal.shade800,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      item.word,
                      style: GoogleFonts.comfortaa(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              // Image
              Expanded(
                flex: 3,
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Image.asset(
                    item.image,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.image_not_supported, size: 64);
                    },
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
                        color: Colors.teal.shade800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...item.examples.map((example) => Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Text(
                            '• $example',
                            style: GoogleFonts.comfortaa(
                              fontSize: 14,
                              color: Colors.teal.shade700,
                            ),
                          ),
                        )),
                  ],
                ),
              ),
              // Tap indicator
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.volume_up, color: Colors.teal),
                  const SizedBox(width: 4),
                  Text(
                    'Tap to hear',
                    style: GoogleFonts.comfortaa(
                      fontSize: 14,
                      color: Colors.teal.shade700,
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