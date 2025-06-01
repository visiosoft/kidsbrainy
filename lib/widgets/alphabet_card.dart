import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../models/alphabet_item.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AlphabetCard extends StatefulWidget {
  final AlphabetItem item;

  const AlphabetCard({Key? key, required this.item}) : super(key: key);

  @override
  State<AlphabetCard> createState() => _AlphabetCardState();
}

class _AlphabetCardState extends State<AlphabetCard> {
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
                  child: SvgPicture.asset(
                    widget.item.image,
                    fit: BoxFit.contain,
                    placeholderBuilder: (context) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorBuilder: (context, error, stackTrace) {
                      debugPrint('Error loading SVG: $error');
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.error_outline, size: 48, color: Colors.red),
                            const SizedBox(height: 8),
                            Text(
                              'Error loading image',
                              style: GoogleFonts.comfortaa(
                                fontSize: 14,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      );
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
                      widget.item.upperCase,
                      style: GoogleFonts.comfortaa(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo.shade800,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      widget.item.lowerCase,
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
                widget.item.word,
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