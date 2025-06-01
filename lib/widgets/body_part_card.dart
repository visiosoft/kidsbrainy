import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../models/body_part_item.dart';
import 'package:google_fonts/google_fonts.dart';

class BodyPartCard extends StatefulWidget {
  final BodyPartItem item;

  const BodyPartCard({Key? key, required this.item}) : super(key: key);

  @override
  State<BodyPartCard> createState() => _BodyPartCardState();
}

class _BodyPartCardState extends State<BodyPartCard> {
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
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: LinearGradient(
              colors: [Colors.pink.shade100, Colors.purple.shade50],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Body part name and system
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.item.name,
                    style: GoogleFonts.comfortaa(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple.shade800,
                    ),
                  ),
                  Text(
                    widget.item.system,
                    style: GoogleFonts.comfortaa(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      color: Colors.purple.shade600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Image
              Expanded(
                flex: 3,
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.purple.withOpacity(0.2),
                        blurRadius: 10,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Image.asset(
                    widget.item.image,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      debugPrint('Error loading image: $error');
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.error_outline, size: 48, color: Colors.red),
                            const SizedBox(height: 4),
                            Text(
                              'Error loading image',
                              style: GoogleFonts.comfortaa(
                                fontSize: 12,
                                color: Colors.red,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 8),
              // Description
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  widget.item.description,
                  style: GoogleFonts.comfortaa(
                    fontSize: 12,
                    color: Colors.purple.shade800,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 8),
              // Functions
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Functions:',
                        style: GoogleFonts.comfortaa(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple.shade800,
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: widget.item.functions.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 2),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '• ',
                                    style: GoogleFonts.comfortaa(
                                      fontSize: 12,
                                      color: Colors.purple.shade700,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      widget.item.functions[index],
                                      style: GoogleFonts.comfortaa(
                                        fontSize: 12,
                                        color: Colors.purple.shade700,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Tap indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.volume_up, size: 16, color: Colors.purple),
                  const SizedBox(width: 4),
                  Text(
                    'Tap to hear',
                    style: GoogleFonts.comfortaa(
                      fontSize: 12,
                      color: Colors.purple.shade700,
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