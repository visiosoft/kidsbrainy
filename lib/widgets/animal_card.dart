import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../models/animal_item.dart';
import 'package:google_fonts/google_fonts.dart';

class AnimalCard extends StatelessWidget {
  final AnimalItem item;
  final AudioPlayer audioPlayer = AudioPlayer();

  AnimalCard({Key? key, required this.item}) : super(key: key);

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
              colors: [Colors.pink.shade50, Colors.amber.shade100],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Animal name and category
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          item.name,
                          style: GoogleFonts.comfortaa(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.pink.shade800,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.pink.shade100,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            item.category,
                            style: GoogleFonts.comfortaa(
                              fontSize: 14,
                              color: Colors.pink.shade700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Animal image
              Expanded(
                flex: 3,
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        spreadRadius: 1,
                      ),
                    ],
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
              // Animal facts
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.pink.shade100),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Fun Facts:',
                        style: GoogleFonts.comfortaa(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.pink.shade700,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...item.facts.map((fact) => Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.star, size: 16, color: Colors.amber.shade700),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              fact,
                              style: GoogleFonts.comfortaa(
                                fontSize: 12,
                                color: Colors.pink.shade900,
                              ),
                            ),
                          ),
                        ],
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
                  Icon(Icons.volume_up, color: Colors.pink.shade700),
                  const SizedBox(width: 4),
                  Text(
                    'Tap to hear animal sound',
                    style: GoogleFonts.comfortaa(
                      fontSize: 14,
                      color: Colors.pink.shade700,
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