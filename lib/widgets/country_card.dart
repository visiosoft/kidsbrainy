import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../models/country_item.dart';
import 'package:google_fonts/google_fonts.dart';

class CountryCard extends StatelessWidget {
  final CountryItem item;
  final AudioPlayer audioPlayer = AudioPlayer();

  CountryCard({Key? key, required this.item}) : super(key: key);

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
              colors: [Colors.white, Colors.blue.shade100],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Country name
              Text(
                item.name,
                style: GoogleFonts.comfortaa(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade800,
                  shadows: [
                    Shadow(
                      blurRadius: 2.0,
                      color: Colors.black.withOpacity(0.1),
                      offset: const Offset(1, 1),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              // Capital and continent
              Text(
                '${item.capital} • ${item.continent}',
                style: GoogleFonts.comfortaa(
                  fontSize: 16,
                  color: Colors.blue.shade600,
                ),
              ),
              const SizedBox(height: 16),
              // Flag and map
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    // Flag
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.grey.shade300,
                            width: 2,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: Image.asset(
                            item.flag,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.image_not_supported, size: 64, color: Colors.blue);
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Map
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.grey.shade300,
                            width: 2,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: Image.asset(
                            item.map,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.map, size: 64, color: Colors.blue);
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Facts
              Expanded(
                child: ListView.builder(
                  itemCount: item.facts.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.star, size: 16, color: Colors.blue.shade400),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              item.facts[index],
                              style: GoogleFonts.comfortaa(
                                fontSize: 14,
                                color: Colors.blue.shade900,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 8),
              // Sound indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.volume_up, color: Colors.blue),
                  const SizedBox(width: 4),
                  Text(
                    'Tap to hear about ${item.name}',
                    style: GoogleFonts.comfortaa(
                      fontSize: 14,
                      color: Colors.blue.shade700,
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