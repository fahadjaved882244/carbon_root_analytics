import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 0,
      floating: true,
      pinned: true,
      backgroundColor: const Color(0xFF0f172a).withOpacity(0.95),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFF0f172a).withOpacity(0.95),
              const Color(0xFF1e293b).withOpacity(0.95),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Color(0xFF10b981), Color(0xFF3b82f6)],
                  ).createShader(bounds),
                  child: const Text(
                    'CRA',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                // Row(
                //   children: [
                //     _buildNavButton('Services', () => _scrollToSection(700)),
                //     const SizedBox(width: 20),
                //     _buildNavButton('About', () => _scrollToSection(1200)),
                //     const SizedBox(width: 20),
                //     _buildNavButton('Contact', () => _scrollToSection(2000)),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildNavButton(String text, VoidCallback onPressed) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
