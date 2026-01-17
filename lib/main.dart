import 'package:flutter/material.dart';
import 'widgets/glowing_text.dart';
import 'data/categories.dart';

void main() {
  runApp(const AnimeQuoteApp());
}

class AnimeQuoteApp extends StatelessWidget {
  const AnimeQuoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Main app background gradient (deep night purple)
  LinearGradient get _bgGradient => const LinearGradient(
    colors: [Color(0xFF12091F), Color(0xFF1B0F2E), Color(0xFF2A1846)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      
      //App Bar
      appBar: AppBar(
        title: const GlowingText(text: 'Anime Verse Quotes'),
        backgroundColor: const Color(0xFF1B0F2E),
        centerTitle: true,
      ),

      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(gradient: _bgGradient),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
child: GridView.builder(
  itemCount: categories.length,
  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    crossAxisSpacing: 14,
    mainAxisSpacing: 14,
    childAspectRatio: 0.8,
  ),







  itemBuilder: (context, index) {
  final category = categories[index];
  final imagePath = category['image']!;

  return InkWell(
    borderRadius: BorderRadius.circular(22),
    onTap: () {
      // later: navigate to quotes screen
    },
    child: ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: Stack(
        children: [

          // IMAGE WITH COLOR BLEND
          Positioned.fill(
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                const Color(0xFF12091F).withValues(alpha: 0.6),
                BlendMode.lighten, // cinematic blend
              ),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),

          // GRADIENT OVERLAY (blends image into app background)
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Color(0xFF12091F),
                  ],
                ),
              ),
            ),
          ),

          // SOFT BORDER (premium look)
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.08),
                width: 1,
              ),
            ),
          ),
        ],
      ),
    ),
  );
              },
            ),
          ),
        ),
      ),
    );
  }
}