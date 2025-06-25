import 'package:carbon_root_analytics/features/navigation_console/view/widgets/responsive_padding.dart';
import 'package:flutter/material.dart';

class ReductionInitiativesPage extends StatefulWidget {
  const ReductionInitiativesPage({super.key});

  @override
  createState() => _ReductionInitiativesPageState();
}

class _ReductionInitiativesPageState extends State<ReductionInitiativesPage> {
  String selectedTab = 'Active';
  int currentPage = 1;

  final List<Initiative> myInitiatives = [
    Initiative(
      title: 'Energy Efficiency Improvements',
      description:
          'Switch to LED lighting and motion sensors. Install smart meters and energy monitoring systems.',
      scopeType: 'Scope 2 - Indirect Emissions',
      progress: 26,
      energySavings: '3,000',
      co2Saved: '1,500',
      icon: Icons.electrical_services,
      color: Color(0xFF9ACD32),
    ),
    Initiative(
      title: 'Waste Reduction & Circular Economy',
      description:
          'Introduce recycling stations and composting bins. Reduce paper use through digital workflows.',
      scopeType: 'Scope 3 Other Indirect Emissions',
      progress: 45,
      wasteReduction: '76',
      recyclingRate: '48',
      icon: Icons.recycling,
      color: Color(0xFF9ACD32),
    ),
  ];

  final List<InitiativeCard> allInitiatives = [
    InitiativeCard(
      title: 'Renewable Energy Adoption',
      description:
          'Install solar panels on premises or join community solar schemes. Purchase renewable electricity tariffs.',
      scopeType: 'Scope 2 - Indirect Emissions',
      icon: Icons.solar_power,
      color: Color(0xFF9ACD32),
      metric1Title: 'Generate Renewable Energy',
      metric1Value: '323 MWh',
      details: [
        'Install solar panels on premises or join community solar schemes',
        'Purchase renewable electricity tariffs from certified green suppliers',
        'Join Power Purchase Agreements (PPAs) to fund clean energy projects',
      ],
    ),
    InitiativeCard(
      title: 'Sustainable Transportation',
      description:
          'Switch to electric or hybrid company vehicles. Promote public transport schemes or cycle-to-work programs.',
      scopeType: 'Scope 1 - Direct Emissions',
      icon: Icons.electric_car,
      color: Color(0xFF9ACD32),
      metric1Title: 'Fleet Electrification',
      metric1Value: '65%',
      details: [
        'Switch to electric or hybrid company vehicles',
        'Promote public transport schemes or cycle-to-work programs',
        'Use route optimization software for deliveries and logistics',
        'Offer remote working or flexible hours to reduce commuting',
      ],
    ),
    InitiativeCard(
      title: 'Supply Chain & Procurement',
      description:
          'Choose local and low-carbon suppliers. Ask suppliers to provide carbon footprint disclosures.',
      scopeType: 'Scope 3 Other Indirect Emissions',
      icon: Icons.local_shipping,
      color: Color(0xFF9ACD32),
      metric1Title: 'Local Suppliers',
      metric1Value: '42%',
      details: [
        'Choose local and low-carbon suppliers',
        'Ask suppliers to provide carbon footprint disclosures',
        'Bundle shipments to reduce transport frequency',
        'Encourage suppliers to adhere to ISO 14001 or B Corp standards',
      ],
    ),
    InitiativeCard(
      title: 'IT & Digital Sustainability',
      description:
          'Use cloud services with green data centres. Refurbish and extend the life of hardware.',
      scopeType: 'Scope 2 - Indirect Emissions',
      icon: Icons.computer,
      color: Color(0xFF9ACD32),
      metric1Title: 'Green IT Adoption',
      metric1Value: '78%',
      details: [
        'Use cloud services with green data centres (e.g., AWS, Google Cloud)',
        'Refurbish and extend the life of hardware',
        'Conduct regular IT carbon audits',
        'Optimize digital tools to reduce server loads and data storage',
      ],
    ),
    InitiativeCard(
      title: 'Green Office Practices',
      description:
          'Adopt flexible workspace design to reduce heating/cooling needs. Provide plant-based meals.',
      scopeType: 'Scope 1 - Direct Emissions',
      icon: Icons.business,
      color: Color(0xFF9ACD32),
      metric1Title: 'Office Efficiency',
      metric1Value: '55%',
      details: [
        'Adopt flexible workspace design to reduce heating/cooling needs',
        'Provide plant-based meals at events or canteens',
        'Engage employees in carbon literacy training and green goals',
        'Apply for ISO 50001 (Energy Management) or Carbon Trust Standard',
      ],
    ),
    InitiativeCard(
      title: 'Nature-Based Solutions',
      description:
          'Partner with reforestation or afforestation projects. Green rooftops or vertical gardens.',
      scopeType: 'Scope 3 Other Indirect Emissions',
      icon: Icons.forest,
      color: Color(0xFF9ACD32),
      metric1Title: 'Trees Planted',
      metric1Value: '2,500',
      details: [
        'Partner with reforestation or afforestation projects',
        'Green rooftops or vertical gardens for insulation and biodiversity',
        'Sponsor or join local conservation efforts (e.g., in Manchester)',
      ],
    ),
    InitiativeCard(
      title: 'Monitoring & Reporting',
      description:
          'Use tools like Carbon Root Analytics to track emissions and progress. Set science-based targets.',
      scopeType: 'Scope 2 - Indirect Emissions',
      icon: Icons.analytics,
      color: Color(0xFF9ACD32),
      metric1Title: 'Reporting Accuracy',
      metric1Value: '95%',
      details: [
        'Use tools like Carbon Root Analytics to track emissions and progress',
        'Set science-based targets (SBTi) for emissions reduction',
        'Publish annual sustainability reports with measurable KPIs',
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ResponsivePadding(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildMyInitiativesHeader(),
                SizedBox(height: 24),
                _buildMyInitiativesCards(),
                SizedBox(height: 32),
                _buildAllInitiativesSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMyInitiativesHeader() {
    return Row(
      children: [
        Text(
          'My Initiatives',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Spacer(),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: selectedTab == 'Active'
                ? Color(0xFF9ACD32)
                : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Text(
                'Active',
                style: TextStyle(
                  color: selectedTab == 'Active' ? Colors.white : Colors.black,
                ),
              ),
              SizedBox(width: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '02',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 8),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: selectedTab == 'Completed'
                ? Color(0xFF9ACD32)
                : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            'Completed',
            style: TextStyle(
              color: selectedTab == 'Completed' ? Colors.white : Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMyInitiativesCards() {
    return Column(
      children: myInitiatives
          .map((initiative) => _buildMyInitiativeCard(initiative))
          .toList(),
    );
  }

  Widget _buildMyInitiativeCard(Initiative initiative) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          _buildProgressCircle(initiative.progress),
          SizedBox(width: 20),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  initiative.title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Description',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                Text(initiative.description, style: TextStyle(fontSize: 14)),
                SizedBox(height: 12),
                Text(
                  'Scope Type',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                Text(
                  initiative.scopeType,
                  style: TextStyle(fontSize: 14, color: Colors.blue),
                ),
              ],
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (initiative.energySavings != null) ...[
                  Text(
                    'Energy Savings',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  Text(
                    '${initiative.energySavings} kWh',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'CO₂ Emissions Saved',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '${initiative.co2Saved} Kg ',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: 'CO₂',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
                if (initiative.wasteReduction != null) ...[
                  Text(
                    'Waste Reduction',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  Text(
                    '${initiative.wasteReduction} %',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Recycling Rate',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  Text(
                    '${initiative.recyclingRate} %',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressCircle(int percentage) {
    return Container(
      width: 80,
      height: 80,
      child: Stack(
        children: [
          Center(
            child: SizedBox(
              width: 80,
              height: 80,
              child: CircularProgressIndicator(
                value: percentage / 100,
                strokeWidth: 6,
                backgroundColor: Colors.grey.shade200,
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF9ACD32)),
              ),
            ),
          ),
          Center(
            child: Text(
              '$percentage%',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAllInitiativesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Initiatives',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        SizedBox(
          height: 400,
          child: ListView.separated(
            itemCount: allInitiatives.length,
            itemBuilder: (context, index) {
              return _buildInitiativeCard(allInitiatives[index]);
            },
            separatorBuilder: (context, index) => SizedBox(height: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildInitiativeCard(InitiativeCard initiative) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: initiative.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(initiative.icon, color: initiative.color, size: 24),
          ),
          SizedBox(width: 16),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${initiative.scopeType}',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                Text(
                  initiative.title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  initiative.description,
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                initiative.metric1Title,
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              Text(
                initiative.metric1Value,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(width: 16),
          ElevatedButton(
            onPressed: () => _showInitiativeDetails(initiative),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF9ACD32),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.add, color: Colors.white, size: 16),
                SizedBox(width: 4),
                Text('Join', style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showInitiativeDetails(InitiativeCard initiative) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(initiative.title),
          content: Container(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Scope: ${initiative.scopeType}',
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(height: 16),
                Text(
                  'Key Actions:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                ...initiative.details.map(
                  (detail) => Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '• ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Expanded(child: Text(detail)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Close'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Joined ${initiative.title} initiative!'),
                    backgroundColor: Color(0xFF9ACD32),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF9ACD32),
              ),
              child: Text(
                'Join Initiative',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}

class Initiative {
  final String title;
  final String description;
  final String scopeType;
  final int progress;
  final String? energySavings;
  final String? co2Saved;
  final String? wasteReduction;
  final String? recyclingRate;
  final IconData icon;
  final Color color;

  Initiative({
    required this.title,
    required this.description,
    required this.scopeType,
    required this.progress,
    this.energySavings,
    this.co2Saved,
    this.wasteReduction,
    this.recyclingRate,
    required this.icon,
    required this.color,
  });
}

class InitiativeCard {
  final String title;
  final String description;
  final String scopeType;
  final IconData icon;
  final Color color;
  final String metric1Title;
  final String metric1Value;
  final List<String> details;

  InitiativeCard({
    required this.title,
    required this.description,
    required this.scopeType,
    required this.icon,
    required this.color,
    required this.metric1Title,
    required this.metric1Value,
    required this.details,
  });
}
