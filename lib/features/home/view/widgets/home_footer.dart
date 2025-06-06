import 'package:carbon_root_analytics/features/navigation_console/view/widgets/responsive_padding.dart';
import 'package:flutter/material.dart';

class HomeFooter extends StatelessWidget {
  const HomeFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(color: Color(0xFF0f172a).withOpacity(0.8)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: ResponsivePadding(
          child: Column(
            children: [
              SizedBox(height: 24),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        const Text(
                          'Contact Us',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF10b981),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Email: info@cra-manchester.co.uk',
                          style: TextStyle(color: Colors.white70),
                        ),
                        const SizedBox(height: 4),

                        const Text(
                          'Phone: +44 161 123 4567',
                          style: TextStyle(color: Colors.white70),
                        ),
                        const SizedBox(height: 4),

                        const Text(
                          'Address: Manchester, UK',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        const Text(
                          'Services',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF10b981),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Carbon Footprint Analysis',
                          style: TextStyle(color: Colors.white70),
                        ),
                        const SizedBox(height: 4),

                        const Text(
                          'Net-Zero Strategy',
                          style: TextStyle(color: Colors.white70),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Sustainability Consulting',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Divider(color: Colors.white24),
              const SizedBox(height: 16),
              const Text(
                '© 2024 CRA - Carbon Root Analytics. All rights reserved.',
                style: TextStyle(color: Colors.white54, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
