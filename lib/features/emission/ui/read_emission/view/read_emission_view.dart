// pubspec.yaml dependencies needed:
// dependencies:
//   flutter:
//     sdk: flutter
//   fl_chart: ^0.68.0
//   hooks_riverpod: ^2.4.9
//   flutter_hooks: ^0.20.5

import 'package:carbon_root_analytics/features/navigation_console/view/widgets/responsive_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math' as math;

// Data Models
class EmissionData {
  final String month;
  final double scope1;
  final double scope2;
  final double scope3;
  final double total;
  final double target;

  EmissionData({
    required this.month,
    required this.scope1,
    required this.scope2,
    required this.scope3,
    required this.total,
    required this.target,
  });
}

class ScopeBreakdown {
  final String category;
  final double value;
  final Color color;

  ScopeBreakdown({
    required this.category,
    required this.value,
    required this.color,
  });
}

// Mock Data Provider
final dashboardDataProvider = Provider<List<EmissionData>>((ref) {
  return [
    EmissionData(
      month: 'Jan',
      scope1: 850,
      scope2: 420,
      scope3: 1200,
      total: 2470,
      target: 2200,
    ),
    EmissionData(
      month: 'Feb',
      scope1: 780,
      scope2: 380,
      scope3: 1150,
      total: 2310,
      target: 2100,
    ),
    EmissionData(
      month: 'Mar',
      scope1: 920,
      scope2: 450,
      scope3: 1300,
      total: 2670,
      target: 2000,
    ),
    EmissionData(
      month: 'Apr',
      scope1: 710,
      scope2: 340,
      scope3: 1100,
      total: 2150,
      target: 1900,
    ),
    EmissionData(
      month: 'May',
      scope1: 680,
      scope2: 320,
      scope3: 1050,
      total: 2050,
      target: 1800,
    ),
    EmissionData(
      month: 'Jun',
      scope1: 650,
      scope2: 310,
      scope3: 980,
      total: 1940,
      target: 1700,
    ),
    EmissionData(
      month: 'Jul',
      scope1: 620,
      scope2: 290,
      scope3: 920,
      total: 1830,
      target: 1600,
    ),
    EmissionData(
      month: 'Aug',
      scope1: 590,
      scope2: 270,
      scope3: 890,
      total: 1750,
      target: 1500,
    ),
    EmissionData(
      month: 'Sep',
      scope1: 560,
      scope2: 250,
      scope3: 850,
      total: 1660,
      target: 1400,
    ),
    EmissionData(
      month: 'Oct',
      scope1: 530,
      scope2: 230,
      scope3: 820,
      total: 1580,
      target: 1300,
    ),
    EmissionData(
      month: 'Nov',
      scope1: 500,
      scope2: 210,
      scope3: 780,
      total: 1490,
      target: 1200,
    ),
    EmissionData(
      month: 'Dec',
      scope1: 470,
      scope2: 190,
      scope3: 750,
      total: 1410,
      target: 1100,
    ),
  ];
});

// Net Zero Progress Provider
final netZeroProgressProvider = Provider<double>((ref) {
  final data = ref.watch(dashboardDataProvider);
  final currentEmissions = data.last.total;
  const baselineEmissions = 2470.0; // January baseline

  final progress =
      ((baselineEmissions - currentEmissions) / baselineEmissions) * 100;
  return math.max(0, math.min(100, progress));
});

class CarbonDashboardView extends HookConsumerWidget {
  final String companyId;

  const CarbonDashboardView({super.key, required this.companyId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabController = useTabController(initialLength: 3);
    final data = ref.watch(dashboardDataProvider);
    final netZeroProgress = ref.watch(netZeroProgressProvider);

    return Scaffold(
      body: ResponsivePadding(
        child: Column(
          children: [
            // Tab Bar
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
              ),
              child: TabBar(
                controller: tabController,
                onTap: (index) {
                  tabController.index = index;
                },
                dividerHeight: 0,
                tabs: const [
                  Tab(text: 'Overview', icon: Icon(Icons.dashboard, size: 20)),
                  Tab(text: 'Trends', icon: Icon(Icons.trending_up, size: 20)),
                  Tab(
                    text: 'Progress',
                    icon: Icon(Icons.track_changes, size: 20),
                  ),
                ],
              ),
            ),

            // Content
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  _buildOverviewTab(data, netZeroProgress),
                  _buildTrendsTab(data),
                  _buildProgressTab(data, netZeroProgress),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewTab(List<EmissionData> data, double netZeroProgress) {
    final currentMonth = data.last;
    final previousMonth = data[data.length - 2];
    final monthlyChange =
        ((currentMonth.total - previousMonth.total) / previousMonth.total) *
        100;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // KPI Cards
          Row(
            children: [
              Expanded(
                child: _buildKPICard(
                  'Current Emissions',
                  '${currentMonth.total.toStringAsFixed(0)} tCO₂e',
                  monthlyChange < 0 ? Icons.trending_down : Icons.trending_up,
                  monthlyChange < 0 ? Colors.green : Colors.red,
                  '${monthlyChange.toStringAsFixed(1)}% vs last month',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildKPICard(
                  'Net Zero Progress',
                  '${netZeroProgress.toStringAsFixed(1)}%',
                  Icons.eco,
                  Colors.green,
                  'Towards carbon neutrality',
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Scope Breakdown Pie Chart
          _buildChartCard(
            'Emissions by Scope',
            SizedBox(
              height: 300,
              child: PieChart(
                PieChartData(
                  sections: _buildPieChartSections(currentMonth),
                  centerSpaceRadius: 32,
                  sectionsSpace: 0,
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Scope Breakdown Cards
          Row(
            children: [
              Expanded(
                child: _buildScopeCard(
                  'Scope 1',
                  data.last.scope1,
                  Colors.red.shade400,
                  'Direct emissions',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildScopeCard(
                  'Scope 2',
                  data.last.scope2,
                  Colors.orange.shade400,
                  'Indirect energy',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildScopeCard(
                  'Scope 3',
                  data.last.scope3,
                  Colors.blue.shade400,
                  'Value chain',
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Monthly Trend Line Chart
          _buildChartCard(
            'Monthly Emissions Trend',
            SizedBox(
              height: 300,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: true, drawVerticalLine: false),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 50,
                        getTitlesWidget: (value, meta) => Text(
                          '${value.toInt()}',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          if (value.toInt() >= 0 &&
                              value.toInt() < data.length) {
                            return Text(
                              data[value.toInt()].month,
                              style: const TextStyle(fontSize: 12),
                            );
                          }
                          return const Text('');
                        },
                      ),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: data.asMap().entries.map((entry) {
                        return FlSpot(entry.key.toDouble(), entry.value.total);
                      }).toList(),
                      isCurved: true,
                      color: Colors.blue,
                      barWidth: 3,
                      dotData: const FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: true,
                        color: Colors.blue.withOpacity(0.1),
                      ),
                    ),
                    LineChartBarData(
                      spots: data.asMap().entries.map((entry) {
                        return FlSpot(entry.key.toDouble(), entry.value.target);
                      }).toList(),
                      isCurved: true,
                      color: Colors.red,
                      barWidth: 2,
                      dashArray: [5, 5],
                      dotData: const FlDotData(show: false),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrendsTab(List<EmissionData> data) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Scope Trends Bar Chart
          _buildChartCard(
            'Scope Emissions by Month',
            SizedBox(
              height: 350,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  gridData: FlGridData(show: true, drawVerticalLine: false),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 50,
                        getTitlesWidget: (value, meta) => Text(
                          '${value.toInt()}',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          if (value.toInt() >= 0 &&
                              value.toInt() < data.length) {
                            return Text(
                              data[value.toInt()].month,
                              style: const TextStyle(fontSize: 10),
                            );
                          }
                          return const Text('');
                        },
                      ),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: data.asMap().entries.map((entry) {
                    return BarChartGroupData(
                      x: entry.key,
                      barRods: [
                        BarChartRodData(
                          toY: entry.value.scope1,
                          color: Colors.red.shade400,
                          width: 8,
                        ),
                        BarChartRodData(
                          toY: entry.value.scope2,
                          color: Colors.orange.shade400,
                          width: 8,
                        ),
                        BarChartRodData(
                          toY: entry.value.scope3,
                          color: Colors.blue.shade400,
                          width: 8,
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Area Chart for Cumulative View
          _buildChartCard(
            'Cumulative Emissions Trend',
            SizedBox(
              height: 300,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: true, drawVerticalLine: false),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 50,
                        getTitlesWidget: (value, meta) => Text(
                          '${value.toInt()}',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          if (value.toInt() >= 0 &&
                              value.toInt() < data.length) {
                            return Text(
                              data[value.toInt()].month,
                              style: const TextStyle(fontSize: 10),
                            );
                          }
                          return const Text('');
                        },
                      ),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    // Scope 1
                    LineChartBarData(
                      spots: data.asMap().entries.map((entry) {
                        return FlSpot(entry.key.toDouble(), entry.value.scope1);
                      }).toList(),
                      isCurved: true,
                      color: Colors.red.shade400,
                      barWidth: 2,
                      dotData: const FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: true,
                        color: Colors.red.shade100,
                      ),
                    ),
                    // Scope 2
                    LineChartBarData(
                      spots: data.asMap().entries.map((entry) {
                        return FlSpot(entry.key.toDouble(), entry.value.scope2);
                      }).toList(),
                      isCurved: true,
                      color: Colors.orange.shade400,
                      barWidth: 2,
                      dotData: const FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: true,
                        color: Colors.orange.shade100,
                      ),
                    ),
                    // Scope 3
                    LineChartBarData(
                      spots: data.asMap().entries.map((entry) {
                        return FlSpot(entry.key.toDouble(), entry.value.scope3);
                      }).toList(),
                      isCurved: true,
                      color: Colors.blue.shade400,
                      barWidth: 2,
                      dotData: const FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: true,
                        color: Colors.blue.shade100,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressTab(List<EmissionData> data, double netZeroProgress) {
    final targetYear = 2030;
    final currentYear = DateTime.now().year;
    final yearsRemaining = targetYear - currentYear;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Net Zero Progress Gauge
          _buildChartCard(
            'Net Zero Progress',
            Column(
              children: [
                SizedBox(
                  height: 200,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 160,
                        height: 160,
                        child: CircularProgressIndicator(
                          value: netZeroProgress / 100,
                          strokeWidth: 12,
                          backgroundColor: Colors.grey.shade300,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            netZeroProgress > 70
                                ? Colors.green
                                : netZeroProgress > 40
                                ? Colors.orange
                                : Colors.red,
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${netZeroProgress.toStringAsFixed(1)}%',
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            'Complete',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  '$yearsRemaining years remaining to reach net zero',
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Target vs Actual
          _buildChartCard(
            'Target vs Actual Emissions',
            SizedBox(
              height: 300,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: true, drawVerticalLine: false),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 50,
                        getTitlesWidget: (value, meta) => Text(
                          '${value.toInt()}',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          if (value.toInt() >= 0 &&
                              value.toInt() < data.length) {
                            return Text(
                              data[value.toInt()].month,
                              style: const TextStyle(fontSize: 10),
                            );
                          }
                          return const Text('');
                        },
                      ),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: data.asMap().entries.map((entry) {
                        return FlSpot(entry.key.toDouble(), entry.value.total);
                      }).toList(),
                      isCurved: true,
                      color: Colors.blue,
                      barWidth: 3,
                      dotData: const FlDotData(show: true),
                    ),
                    LineChartBarData(
                      spots: data.asMap().entries.map((entry) {
                        return FlSpot(entry.key.toDouble(), entry.value.target);
                      }).toList(),
                      isCurved: true,
                      color: Colors.green,
                      barWidth: 3,
                      dashArray: [5, 5],
                      dotData: const FlDotData(show: true),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Progress Metrics
          Row(
            children: [
              Expanded(
                child: _buildProgressMetric(
                  'Emissions Reduced',
                  '${(data.first.total - data.last.total).toStringAsFixed(0)} tCO₂e',
                  Icons.trending_down,
                  Colors.green,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildProgressMetric(
                  'Monthly Reduction',
                  '${((data.first.total - data.last.total) / data.length).toStringAsFixed(0)} tCO₂e',
                  Icons.speed,
                  Colors.blue,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildKPICard(
    String title,
    String value,
    IconData icon,
    Color color,
    String subtitle,
  ) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 24),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(fontSize: 12, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChartCard(String title, Widget chart) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            chart,
          ],
        ),
      ),
    );
  }

  Widget _buildScopeCard(
    String title,
    double value,
    Color color,
    String description,
  ) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),
            Text(
              '${value.toStringAsFixed(0)} tCO₂e',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressMetric(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> _buildPieChartSections(EmissionData data) {
    final total = data.scope1 + data.scope2 + data.scope3;

    return [
      PieChartSectionData(
        value: data.scope1,
        color: Colors.red.shade400,
        title: 'Scope 1\n${((data.scope1 / total) * 100).toStringAsFixed(1)}%',
        radius: 100,
        titleStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      PieChartSectionData(
        value: data.scope2,
        color: Colors.orange.shade400,
        title: 'Scope 2\n${((data.scope2 / total) * 100).toStringAsFixed(1)}%',
        radius: 100,
        titleStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      PieChartSectionData(
        value: data.scope3,
        color: Colors.blue.shade400,
        title: 'Scope 3\n${((data.scope3 / total) * 100).toStringAsFixed(1)}%',
        radius: 100,
        titleStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ];
  }
}
