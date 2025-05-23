import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../models/alphabet_item.dart';
import 'package:google_fonts/google_fonts.dart';

class AlphabetCard extends StatelessWidget {
  final AlphabetItem item;
  final AudioPlayer audioPlayer = AudioPlayer();

  AlphabetCard({Key? key, required this.item}) : super(key: key);

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
              colors: [Colors.blue.shade200, Colors.purple.shade100],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
              // Letter display
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      item.upperCase,
                      style: GoogleFonts.comfortaa(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo.shade800,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      item.lowerCase,
                      style: GoogleFonts.comfortaa(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              // Word
              Text(
                item.word,
                style: GoogleFonts.comfortaa(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.indigo.shade900,
                ),
              ),
              // Tap indicator
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.volume_up, color: Colors.indigo),
                  const SizedBox(width: 4),
                  Text(
                    'Tap to hear',
                    style: GoogleFonts.comfortaa(
                      fontSize: 14,
                      color: Colors.indigo.shade600,
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