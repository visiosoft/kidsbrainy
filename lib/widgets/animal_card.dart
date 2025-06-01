import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../models/animal_item.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AnimalCard extends StatefulWidget {
  final AnimalItem item;

  const AnimalCard({Key? key, required this.item}) : super(key: key);

  @override
  State<AnimalCard> createState() => _AnimalCardState();
}

class _AnimalCardState extends State<AnimalCard> {
  AudioPlayer? audioPlayer;

  @override
  void dispose() {
    audioPlayer?.dispose();
    super.dispose();
  }

  void _playSound() async {
    try {
      // Release any existing player
      await audioPlayer?.dispose();
      
      // Create a new instance for each playback
      audioPlayer = AudioPlayer();
      
      // Remove 'assets/' prefix as AssetSource adds it automatically
      final soundPath = widget.item.sound.replaceFirst('assets/', '');
      
      // Play the sound
      await audioPlayer?.play(AssetSource(soundPath));
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
                          widget.item.name,
                          style: GoogleFonts.comfortaa(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.pink.shade800,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 2),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.pink.shade100,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            widget.item.category,
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
                flex: 5,
                child: Container(
                  padding: const EdgeInsets.all(8.0),
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
                  child: widget.item.image.toLowerCase().endsWith('.svg')
                    ? SvgPicture.asset(
                        widget.item.image,
                        fit: BoxFit.contain,
                        width: double.infinity,
                        height: double.infinity,
                        placeholderBuilder: (context) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : Image.asset(
                        widget.item.image,
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
                padding: const EdgeInsets.all(8),
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
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.pink.shade700,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    ...widget.item.facts.map((fact) => Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.star, size: 12, color: Colors.amber.shade700),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              fact,
                              style: GoogleFonts.comfortaa(
                                fontSize: 11,
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
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.volume_up, size: 14, color: Colors.pink.shade700),
                  const SizedBox(width: 4),
                  Text(
                    'Tap to hear sound',
                    style: GoogleFonts.comfortaa(
                      fontSize: 12,
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