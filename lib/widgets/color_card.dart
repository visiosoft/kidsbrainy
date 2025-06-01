import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../models/color_item.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ColorCard extends StatefulWidget {
  final ColorItem item;

  const ColorCard({Key? key, required this.item}) : super(key: key);

  @override
  State<ColorCard> createState() => _ColorCardState();
}

class _ColorCardState extends State<ColorCard> {
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
              colors: [widget.item.color.withOpacity(0.7), widget.item.color.withOpacity(0.3)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Color name
              Expanded(
                flex: 1,
                child: Center(
                  child: Text(
                    widget.item.name,
                    style: GoogleFonts.comfortaa(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: _getContrastColor(widget.item.color),
                    ),
                  ),
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
                  child: widget.item.image.endsWith('.svg')
                      ? SvgPicture.asset(
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
              // Color sample
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: widget.item.color,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
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
                        color: _getContrastColor(widget.item.color),
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...widget.item.examples.map((example) => Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Text(
                            '• $example',
                            style: GoogleFonts.comfortaa(
                              fontSize: 14,
                              color: _getContrastColor(widget.item.color),
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
                  Icon(Icons.volume_up, color: _getContrastColor(widget.item.color)),
                  const SizedBox(width: 4),
                  Text(
                    'Tap to hear',
                    style: GoogleFonts.comfortaa(
                      fontSize: 14,
                      color: _getContrastColor(widget.item.color),
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

  Color _getContrastColor(Color color) {
    // Calculate the perceived brightness of the color
    double brightness = (0.299 * color.red + 0.587 * color.green + 0.114 * color.blue) / 255;
    return brightness > 0.5 ? Colors.black : Colors.white;
  }
} 