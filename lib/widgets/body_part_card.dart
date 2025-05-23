import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../models/body_part_item.dart';
import 'package:google_fonts/google_fonts.dart';

class BodyPartCard extends StatelessWidget {
  final BodyPartItem item;
  final AudioPlayer audioPlayer = AudioPlayer();

  BodyPartCard({Key? key, required this.item}) : super(key: key);

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
              colors: [Colors.white, Colors.green.shade100],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Body part name
              Text(
                item.name,
                style: GoogleFonts.comfortaa(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade800,
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
              // System
              Text(
                item.system,
                style: GoogleFonts.comfortaa(
                  fontSize: 16,
                  color: Colors.green.shade600,
                ),
              ),
              const SizedBox(height: 16),
              // Image
              Expanded(
                flex: 2,
                child: Container(
                  width: double.infinity,
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
                      item.image,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.image_not_supported, size: 64, color: Colors.green);
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Description
              Text(
                item.description,
                textAlign: TextAlign.center,
                style: GoogleFonts.comfortaa(
                  fontSize: 14,
                  color: Colors.green.shade900,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 16),
              // Functions
              Expanded(
                child: ListView.builder(
                  itemCount: item.functions.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.check_circle, size: 16, color: Colors.green.shade400),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              item.functions[index],
                              style: GoogleFonts.comfortaa(
                                fontSize: 14,
                                color: Colors.green.shade900,
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
                  const Icon(Icons.volume_up, color: Colors.green),
                  const SizedBox(width: 4),
                  Text(
                    'Tap to learn about ${item.name}',
                    style: GoogleFonts.comfortaa(
                      fontSize: 14,
                      color: Colors.green.shade700,
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