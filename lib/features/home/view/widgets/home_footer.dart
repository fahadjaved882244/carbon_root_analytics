import 'package:flutter/material.dart';

class HomeFooter extends StatelessWidget {
  const HomeFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      color: const Color(0xFF0f172a).withOpacity(0.8),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Contact Us',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF10b981),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Email: info@cra-manchester.co.uk',
                      style: TextStyle(color: Colors.white70),
                    ),
                    const Text(
                      'Phone: +44 161 123 4567',
                      style: TextStyle(color: Colors.white70),
                    ),
                    const Text(
                      'Address: Manchester, UK',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Services',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF10b981),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Carbon Footprint Analysis',
                      style: TextStyle(color: Colors.white70),
                    ),
                    const Text(
                      'Net-Zero Strategy',
                      style: TextStyle(color: Colors.white70),
                    ),
                    const Text(
                      'Sustainability Consulting',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          const Divider(color: Colors.white24),
          const SizedBox(height: 20),
          const Text(
            '© 2024 CRA - Carbon Root Analytics. All rights reserved.',
            style: TextStyle(color: Colors.white54, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
