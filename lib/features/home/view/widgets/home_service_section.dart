import 'package:flutter/material.dart';

class HomeServiceSection extends StatelessWidget {
  const HomeServiceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [Color(0xFF10b981), Color(0xFF3b82f6)],
            ).createShader(bounds),
            child: const Text(
              'Our Services',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 40),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: MediaQuery.of(context).size.width > 800 ? 3 : 1,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: 1.2,
            children: [
              _buildServiceCard(
                '📊',
                'Carbon Footprint Analysis',
                'Comprehensive assessment of your company\'s carbon emissions across all operations.',
              ),
              _buildServiceCard(
                '🎯',
                'Net-Zero Strategy Development',
                'Customized roadmaps to achieve carbon neutrality for Manchester businesses.',
              ),
              _buildServiceCard(
                '📈',
                'Real-Time Monitoring',
                'Advanced analytics platform with continuous tracking and actionable insights.',
              ),
              _buildServiceCard(
                '🌱',
                'Sustainability Consulting',
                'Expert guidance on sustainable practices that improve operational efficiency.',
              ),
              _buildServiceCard(
                '📋',
                'Compliance Reporting',
                'Automated generation of compliance reports for regulatory requirements.',
              ),
              _buildServiceCard(
                '🤝',
                'CCAP 2038 Support',
                'Specialized assistance to align with Manchester\'s Climate Change Action Plan.',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(String icon, String title, String description) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 800),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 20 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white.withOpacity(0.1)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF10b981), Color(0xFF3b82f6)],
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: Text(icon, style: const TextStyle(fontSize: 24)),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF10b981),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
