import 'package:flutter/material.dart';
import '../data/color_data.dart';
import '../widgets/color_card.dart';
import 'package:google_fonts/google_fonts.dart';

class ColorScreen extends StatefulWidget {
  const ColorScreen({Key? key}) : super(key: key);

  @override
  _ColorScreenState createState() => _ColorScreenState();
}

class _ColorScreenState extends State<ColorScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Learn Colors',
          style: GoogleFonts.comfortaa(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.orange.shade300,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Progress bar
          Container(
            height: 10,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: LinearProgressIndicator(
                value: (_currentPage + 1) / colorData.length,
                backgroundColor: Colors.grey.shade200,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.orange.shade300),
              ),
            ),
          ),
          // Page number indicator
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Color ${_currentPage + 1} of ${colorData.length}',
                  style: GoogleFonts.comfortaa(
                    fontSize: 14,
                    color: Colors.grey.shade700,
                  ),
                ),
                Text(
                  colorData[_currentPage].name,
                  style: GoogleFonts.comfortaa(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: colorData[_currentPage].color,
                  ),
                ),
              ],
            ),
          ),
          // Main content
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: colorData.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ColorCard(item: colorData[index]),
                );
              },
            ),
          ),
          // Navigation buttons
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: _currentPage == 0
                      ? null
                      : () {
                          _pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Previous'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange.shade300,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _currentPage == colorData.length - 1
                      ? null
                      : () {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text('Next'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange.shade300,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 