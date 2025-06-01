import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../models/country_item.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CountryCard extends StatefulWidget {
  final CountryItem item;

  const CountryCard({Key? key, required this.item}) : super(key: key);

  @override
  State<CountryCard> createState() => _CountryCardState();
}

class _CountryCardState extends State<CountryCard> {
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
              colors: [Colors.blue.shade100, Colors.indigo.shade100],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Country name and continent
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
              Text(
                      widget.item.name,
                style: GoogleFonts.comfortaa(
                        fontSize: 28,
                  fontWeight: FontWeight.bold,
                        color: Colors.indigo.shade800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Capital: ${widget.item.capital}',
                      style: GoogleFonts.comfortaa(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.indigo.shade600,
                      ),
                    ),
                    Text(
                      'Continent: ${widget.item.continent}',
                      style: GoogleFonts.comfortaa(
                        fontSize: 14,
                        color: Colors.indigo.shade500,
                      ),
                    ),
                  ],
                ),
              ),
              // Flag and map
              Expanded(
                flex: 3,
                child: Row(
                  children: [
                    // Flag
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 5,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Flag',
                              style: GoogleFonts.comfortaa(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.indigo.shade700,
                              ),
                            ),
                            Expanded(
                              child: widget.item.flag.endsWith('.svg')
                                  ? SvgPicture.asset(
                                      widget.item.flag,
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
                                              const Icon(Icons.error_outline, size: 36, color: Colors.red),
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
                                    )
                                  : Image.asset(
                                      widget.item.flag,
                                      fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                                        return const Icon(Icons.image_not_supported, size: 48);
                            },
                          ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Map
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 5,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Map',
                              style: GoogleFonts.comfortaa(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.indigo.shade700,
                              ),
                            ),
                            Expanded(
                              child: widget.item.map.endsWith('.svg')
                                  ? SvgPicture.asset(
                                      widget.item.map,
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
                                              const Icon(Icons.error_outline, size: 36, color: Colors.red),
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
                                    )
                                  : Image.asset(
                                      widget.item.map,
                                      fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                                        return const Icon(Icons.image_not_supported, size: 48);
                            },
                          ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Facts
              Expanded(
                flex: 2,
                child: Container(
                  margin: const EdgeInsets.only(top: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Interesting Facts:',
                        style: GoogleFonts.comfortaa(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo.shade800,
                        ),
                      ),
                      const SizedBox(height: 4),
              Expanded(
                child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: widget.item.facts.length,
                  itemBuilder: (context, index) {
                    return Padding(
                              padding: const EdgeInsets.only(bottom: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                                  Text(
                                    '• ',
                                    style: GoogleFonts.comfortaa(
                                      fontSize: 14,
                                      color: Colors.indigo.shade700,
                                    ),
                                  ),
                          Expanded(
                            child: Text(
                                      widget.item.facts[index],
                              style: GoogleFonts.comfortaa(
                                fontSize: 14,
                                        color: Colors.indigo.shade700,
                              ),
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
                      color: Colors.indigo.shade700,
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