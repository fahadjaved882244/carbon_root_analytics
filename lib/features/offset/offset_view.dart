import 'package:carbon_root_analytics/features/navigation_console/utils/media_query_extension.dart';
import 'package:carbon_root_analytics/features/navigation_console/view/widgets/responsive_padding.dart';
import 'package:flutter/material.dart';

final List<Map<String, dynamic>> _cards = [
  {
    'image': 'assets/offset/offset_image_1.png',
    'title': 'Trafford Urban Reforestation',
    'subtitle': 'Trees planted: 8,000+',
    'impact': 'Impact: Air quality, biodiversity, carbon removal',
    'icon': Icons.park,
    'color': Colors.green,
  },
  {
    'image': 'assets/offset/offset_image_2.png',
    'title': 'Salford Community Solar Grid',
    'subtitle': 'Rooftop installations for low-income housing',
    'impact': 'Impact: Clean energy, long-term CO₂ savings',
    'icon': Icons.solar_power,
    'color': Colors.orange,
  },
  {
    'image': 'assets/offset/offset_image_3.png',
    'title': 'Greater Manchester Soil Carbon Project',
    'subtitle': 'Regenerative agriculture pilot',
    'impact': 'Impact: CO₂ capture, sustainable farming, local employment',
    'icon': Icons.agriculture,
    'color': Colors.brown,
  },
];

class OffsetView extends StatefulWidget {
  const OffsetView({super.key});

  @override
  createState() => _OffsetViewState();
}

class _OffsetViewState extends State<OffsetView> {
  final ScrollController _scrollController = ScrollController();
  double _emissionAmount = 12.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeroSection(),
            ResponsivePadding(
              child: Column(
                children: [
                  _buildHowItWorksSection(),
                  _buildWhyOffsetSection(),
                  _buildProjectsSection(context),
                  _buildPricingSection(),
                  _buildCTASection(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/offset/background.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Offset your Emissions\nwith Carbon Root',
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              height: 1.2,
            ),
          ),
          SizedBox(height: 16),
          SizedBox(
            width: 480,
            child: Text(
              'Carbon Root Analytics allows you to offset your carbon emissions directly through trusted, certified projects right here in Greater Manchester.',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
          SizedBox(height: 32),
          ElevatedButton(
            onPressed: () => _scrollToSection(1),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Start Offsetting Now',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHowItWorksSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      color: Colors.grey.shade50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'How It Works',
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 48),
          Column(
            children: [
              _buildStep(
                '1',
                'Calculate Your Emissions',
                'Use our built-in calculator or import data from your ERP system.',
                Icons.calculate,
              ),
              _buildStep(
                '2',
                'Select Your Offset Amount',
                'Choose how many tonnes you\'d like to offset — pay only £10 per tonne.',
                Icons.tune,
              ),
              _buildStep(
                '3',
                'Pick a Local Project',
                'Support initiatives like urban tree planting, renewable energy, or soil restoration in Greater Manchester.',
                Icons.location_on,
              ),
              _buildStep(
                '4',
                'Get Verified',
                'Receive an official offset certificate with project details and carbon tonnes removed.',
                Icons.verified,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStep(
    String number,
    String title,
    String description,
    IconData icon,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 32),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(width: 24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(icon, color: Colors.green),
                    SizedBox(width: 8),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWhyOffsetSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Why Offset?',
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 24),
          Text(
            'Carbon Root Analytics allows you to offset your carbon emissions directly through trusted, certified projects right here in Greater Manchester.',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey.shade700,
              height: 1.5,
            ),
          ),
          SizedBox(height: 32),
          Column(
            children: [
              _buildBenefit(
                'Neutralize your carbon footprint responsibly',
                Icons.balance,
              ),
              _buildBenefit(
                'Support local environmental projects in Manchester',
                Icons.local_florist,
              ),
              _buildBenefit(
                'Meet customer, regulatory, and tendering expectations',
                Icons.check_circle,
              ),
              _buildBenefit(
                'Take immediate action while working toward long-term reductions',
                Icons.speed,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBenefit(String text, IconData icon) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Icon(icon, color: Colors.green, size: 24),
          SizedBox(width: 16),
          Expanded(child: Text(text, style: TextStyle(fontSize: 16))),
        ],
      ),
    );
  }

  Widget _buildProjectsSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      color: Colors.grey.shade50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Offset Projects We Support',
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 48),
          SizedBox(
            height: context.isPhone ? 816 : 400,
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                mainAxisExtent: 400,
                maxCrossAxisExtent: 250,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                // Adjust the aspect ratio based on available width and height
                childAspectRatio: 0.75,
              ),
              itemCount: _cards.length,
              itemBuilder: (context, index) {
                final card = _cards[index];
                return _buildProjectCard(
                  card['image'] as String,
                  card['title'] as String,
                  card['subtitle'] as String,
                  card['impact'] as String,
                  card['icon'] as IconData,
                  card['color'] as Color,
                );
              },
            ),
          ),

          SizedBox(height: 32),
          Text(
            'All projects are independently verified and aligned with the Manchester Climate Change Action Plan (CCAP).',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectCard(
    String image,
    String title,
    String subtitle,
    String impact,
    IconData icon,
    Color color,
  ) {
    return Card(
      child: Column(
        children: [
          // image
          Container(
            height: 232,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                  ),
                  Expanded(
                    child: Text(
                      impact,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPricingSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pricing',
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 48),
          Container(
            padding: EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.green.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '£10 per tonne of CO₂',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade800,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '(No hidden fees. 100% of offset cost goes toward local project funding.)',
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                ),
                SizedBox(height: 32),
                Text(
                  'Offset Cost Calculator:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Text('Tonnes to offset:', style: TextStyle(fontSize: 16)),
                    SizedBox(width: 16),
                    Expanded(
                      child: Slider(
                        value: _emissionAmount,
                        min: 1,
                        max: 100,
                        divisions: 99,
                        label: _emissionAmount.round().toString(),
                        onChanged: (value) {
                          setState(() {
                            _emissionAmount = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Text(
                  'Example: Offsetting ${_emissionAmount.round()} tonnes = £${(_emissionAmount * 10).round()}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.green.shade800,
                  ),
                ),
                SizedBox(height: 32),
                Text(
                  'You\'ll receive:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 16),
                Column(
                  children: [
                    _buildReceiveItem('PDF Certificate', Icons.picture_as_pdf),
                    _buildReceiveItem(
                      'Public offset log on your Carbon Root dashboard',
                      Icons.dashboard,
                    ),
                    _buildReceiveItem(
                      'Quarterly project impact updates',
                      Icons.update,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReceiveItem(String text, IconData icon) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, color: Colors.green, size: 20),
          SizedBox(width: 12),
          Expanded(child: Text(text, style: TextStyle(fontSize: 16))),
        ],
      ),
    );
  }

  Widget _buildCTASection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      color: Colors.green.shade800,
      child: Column(
        children: [
          Text(
            'Ready to take action?',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              _showOffsetDialog();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.green.shade800,
              padding: EdgeInsets.symmetric(horizontal: 48, vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Start Offsetting Now',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  void _scrollToSection(int section) {
    double offset = 0;
    switch (section) {
      case 1:
        offset = 600;
        break;
      case 2:
        offset = 1200;
        break;
    }
    _scrollController.animateTo(
      offset,
      duration: Duration(milliseconds: 800),
      curve: Curves.easeInOut,
    );
  }

  void _showOffsetDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Start Your Carbon Offset Journey'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Ready to offset your carbon emissions?'),
              SizedBox(height: 16),
              Text('• Calculate your emissions'),
              Text('• Choose your offset amount'),
              Text('• Select a local project'),
              Text('• Get verified'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Maybe Later'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Offset process would start here!'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: Text('Get Started', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}
