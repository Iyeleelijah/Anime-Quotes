// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/models/quotes.dart';

class QuoteScreen extends StatefulWidget {
  final String categoryId;
  final List<Quote> quotes;

  const QuoteScreen({
    super.key,
    required this.categoryId,
    required this.quotes,
  });

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  int index = 0;
  bool isFav = false;

  LinearGradient get _bgGradient => const LinearGradient(
    colors: [Color(0xFF12091F), Color(0xFF1B0F2E), Color(0xFF2A1846)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  Quote get currentQuote => widget.quotes[index];

  String get favKey => 'fav_${widget.categoryId}_$index';

  @override
  void initState() {
    super.initState();
    _loadFav();
  }

  Future<void> _loadFav() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() => isFav = prefs.getBool(favKey) ?? false);
  }

  Future<void> _toggleFav() async {
    final prefs = await SharedPreferences.getInstance();
    final newVal = !isFav;
    await prefs.setBool(favKey, newVal);
    setState(() => isFav = newVal);
  }

  void _next() {
    if (index < widget.quotes.length - 1) {
      setState(() => index++);
      _loadFav();
    }
  }

  void _prev() {
    if (index > 0) {
      setState(() => index--);
      _loadFav();
    }
  }

  Future<void> _copy() async {
    await Clipboard.setData(
      ClipboardData(text: '"${currentQuote.text}" — ${currentQuote.author}'),
    );
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Copied ✅')));
  }

  Future<void> _share() async {
    await Share.share('"${currentQuote.text}" — ${currentQuote.author}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text(
          'Anime Quotes',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color(0xFF1B0F2E),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(gradient: _bgGradient),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // QUOTE CARD
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.10),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.25),
                          blurRadius: 18,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            currentQuote.text,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              height: 1.4,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 14),
                          Text(
                            "— ${currentQuote.author}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.75),
                              fontSize: 14,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 14),

                // ACTION BUTTONS
                Row(
                  children: [
                    _ActionBtn(
                      icon: Icons.copy_rounded,
                      label: 'Copy',
                      onTap: _copy,
                    ),
                    const SizedBox(width: 10),
                    _ActionBtn(
                      icon: isFav ? Icons.favorite : Icons.favorite_border,
                      label: 'Fav',
                      onTap: _toggleFav,
                      active: isFav,
                    ),
                    const SizedBox(width: 10),
                    _ActionBtn(
                      icon: Icons.share_rounded,
                      label: 'Share',
                      onTap: _share,
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                // PREV / NEXT
                Row(
                  children: [
                    Expanded(
                      child: _PrimaryBtn(
                        text: 'Previous',
                        onTap: index == 0 ? null : _prev,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _PrimaryBtn(
                        text: 'Next',
                        onTap: index == widget.quotes.length - 1 ? null : _next,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),
                Text(
                  '${index + 1} / ${widget.quotes.length}',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.75),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ActionBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool active;

  const _ActionBtn({
    required this.icon,
    required this.label,
    required this.onTap,
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: active
                ? Colors.pinkAccent.withValues(alpha: 0.18)
                : Colors.white.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withValues(alpha: 0.10)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: Colors.white, size: 20),
              const SizedBox(height: 6),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PrimaryBtn extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;

  const _PrimaryBtn({required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final disabled = onTap == null;
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: disabled
              ? null
              : const LinearGradient(
                  colors: [Color(0xFF7B3FE4), Color(0xFF3B1D73)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
          color: disabled ? Colors.white.withValues(alpha: 0.06) : null,
          border: Border.all(color: Colors.white.withValues(alpha: 0.10)),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white.withValues(alpha: disabled ? 0.45 : 1),
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
