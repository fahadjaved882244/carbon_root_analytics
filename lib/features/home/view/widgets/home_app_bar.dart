import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  final void Function(String) scrollToSection;
  const HomeAppBar({super.key, required this.scrollToSection});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: const Color(0xFF0f172a).withOpacity(0.95),
      title: ShaderMask(
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
      actions: [
        _buildNavButton('Services', () {
          scrollToSection('services');
        }),
        const SizedBox(width: 24),
        _buildNavButton('About', () {
          scrollToSection('about');
        }),
      ],
    );
  }

  Widget _buildNavButton(String text, VoidCallback onPressed) {
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
