import 'package:carbon_root_analytics/features/responsive/view/widgets/responsive_padding.dart';
import 'package:flutter/material.dart';

class HomeAboutSection extends StatelessWidget {
  const HomeAboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: ResponsivePadding(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Column(
            children: [
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [Color(0xFF10b981), Color(0xFF3b82f6)],
                ).createShader(bounds),
                child: const Text(
                  'Leading Manchester\nTowards Net-Zero',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.2,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'CRA specializes in providing comprehensive carbon analytics services to small and medium enterprises in Manchester\'s thriving office and service sector.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'With deep expertise in carbon accounting and environmental analytics, we help businesses understand their environmental impact and provide clear, actionable pathways to carbon neutrality.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      // Adjust the aspect ratio based on available width and height
                      childAspectRatio:
                          constraints.maxWidth / (constraints.maxHeight) * 1.2,
                      children: [
                        _buildStatCard('150+', 'SMEs Served'),
                        _buildStatCard('35%', 'Average Carbon\nReduction'),
                        _buildStatCard('24/7', 'Monitoring\nSupport'),
                        _buildStatCard('2038', 'Net-Zero\nTarget'),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String number, String label) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF10b981).withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFF10b981).withOpacity(0.2)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            number,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF10b981),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12, color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
