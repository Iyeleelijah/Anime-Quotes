import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GlowingText extends StatefulWidget {
  final String text;

  const GlowingText({super.key, required this.text});

  @override
  State<GlowingText> createState() => _GlowingTextState();
}

class _GlowingTextState extends State<GlowingText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _animation = Tween<double>(
      begin: 2,
      end: 8,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Text(
          widget.text,
          style: GoogleFonts.poppins(
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            shadows: [
              Shadow(
                blurRadius: _animation.value,
                color: const Color(0xFF7B3FE4),
              ),
              Shadow(
                blurRadius: _animation.value * 1.5,
                color: const Color(0xFF5A2FC2),
              ),
            ],
          ),
        );
      },
    );
  }
}
