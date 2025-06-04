import 'package:flutter/material.dart';

class HomeServiceSection extends StatelessWidget {
  const HomeServiceSection({super.key});

  static const _cards = [
    {
      'icon': '📊',
      'title': 'Carbon Footprint Analysis',
      'description':
          'Comprehensive assessment of your company\'s carbon emissions across all operations.',
    },
    {
      'icon': '🎯',
      'title': 'Net-Zero Strategy Development',
      'description':
          'Customized roadmaps to achieve carbon neutrality for Manchester businesses.',
    },
    {
      'icon': '📈',
      'title': 'Real-Time Monitoring',
      'description':
          'Advanced analytics platform with continuous tracking and actionable insights.',
    },
    {
      'icon': '🌱',
      'title': 'Sustainability Consulting',
      'description':
          'Expert guidance on sustainable practices that improve operational efficiency.',
    },
    {
      'icon': '📋',
      'title': 'Compliance Reporting',
      'description':
          'Automated generation of compliance reports for regulatory requirements.',
    },
    {
      'icon': '🤝',
      'title': 'CCAP 2038 Support',
      'description':
          'Specialized assistance to align with Manchester\'s Climate Change Action Plan.',
    },
  ];

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
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 6,
            itemBuilder: (context, index) => _buildServiceCard(
              _cards[index]['icon'] as String,
              _cards[index]['title'] as String,
              _cards[index]['description'] as String,
            ),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 250,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.75,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(String icon, String title, String description) {
    return Container(
      padding: const EdgeInsets.all(16),
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
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF10b981),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Text(
              description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white70,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
