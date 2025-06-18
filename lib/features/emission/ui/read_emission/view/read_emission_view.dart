import 'package:carbon_root_analytics/features/emission/domain/emission.dart';
import 'package:carbon_root_analytics/features/emission/ui/read_emission/view/widgets/yearly_chart.dart';
import 'package:carbon_root_analytics/features/navigation_console/view/widgets/responsive_padding.dart';
import 'package:carbon_root_analytics/utils/core/data_time_x.dart';
import 'package:carbon_root_analytics/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math' as math;

// Data Models

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
final dashboardDataProvider = Provider<List<Emission>>((ref) {
  return [
    Emission(
      companyId: 'COMP001',
      monthYear: DateTime.parse('2024-01-01'),
      vehicleFuelLitres: 221.74,
      gasHeatingKWh: 1888.89,
      electricityKWh: 1050.00,
      employeeCommuteKm: 7000.00,
      paperUsageReams: 51,
      cloudUsageHours: 360.00,
    ),
    Emission(
      companyId: 'COMP001',
      monthYear: DateTime.parse('2024-02-01'),
      vehicleFuelLitres: 203.48,
      gasHeatingKWh: 1733.33,
      electricityKWh: 950.00,
      employeeCommuteKm: 6708.33,
      paperUsageReams: 49,
      cloudUsageHours: 345.00,
    ),
    Emission(
      companyId: 'COMP001',
      monthYear: DateTime.parse('2024-03-01'),
      vehicleFuelLitres: 239.13,
      gasHeatingKWh: 2044.44,
      electricityKWh: 1125.00,
      employeeCommuteKm: 7583.33,
      paperUsageReams: 56,
      cloudUsageHours: 390.00,
    ),
    Emission(
      companyId: 'COMP001',
      monthYear: DateTime.parse('2024-04-01'),
      vehicleFuelLitres: 185.22,
      gasHeatingKWh: 1577.78,
      electricityKWh: 850.00,
      employeeCommuteKm: 6416.67,
      paperUsageReams: 47,
      cloudUsageHours: 330.00,
    ),
    Emission(
      companyId: 'COMP001',
      monthYear: DateTime.parse('2024-05-01'),
      vehicleFuelLitres: 177.39,
      gasHeatingKWh: 1511.11,
      electricityKWh: 800.00,
      employeeCommuteKm: 6125.00,
      paperUsageReams: 45,
      cloudUsageHours: 315.00,
    ),
    Emission(
      companyId: 'COMP001',
      monthYear: DateTime.parse('2024-06-01'),
      vehicleFuelLitres: 169.57,
      gasHeatingKWh: 1444.44,
      electricityKWh: 775.00,
      employeeCommuteKm: 5716.67,
      paperUsageReams: 42,
      cloudUsageHours: 294.00,
    ),
    Emission(
      companyId: 'COMP001',
      monthYear: DateTime.parse('2024-07-01'),
      vehicleFuelLitres: 161.74,
      gasHeatingKWh: 1377.78,
      electricityKWh: 725.00,
      employeeCommuteKm: 5366.67,
      paperUsageReams: 39,
      cloudUsageHours: 276.00,
    ),
    Emission(
      companyId: 'COMP001',
      monthYear: DateTime.parse('2024-08-01'),
      vehicleFuelLitres: 153.91,
      gasHeatingKWh: 1311.11,
      electricityKWh: 675.00,
      employeeCommuteKm: 5191.67,
      paperUsageReams: 38,
      cloudUsageHours: 267.00,
    ),
    Emission(
      companyId: 'COMP001',
      monthYear: DateTime.parse('2024-09-01'),
      vehicleFuelLitres: 146.09,
      gasHeatingKWh: 1244.44,
      electricityKWh: 625.00,
      employeeCommuteKm: 4958.33,
      paperUsageReams: 36,
      cloudUsageHours: 255.00,
    ),
    Emission(
      companyId: 'COMP001',
      monthYear: DateTime.parse('2024-10-01'),
      vehicleFuelLitres: 138.26,
      gasHeatingKWh: 1177.78,
      electricityKWh: 575.00,
      employeeCommuteKm: 4783.33,
      paperUsageReams: 35,
      cloudUsageHours: 246.00,
    ),
    Emission(
      companyId: 'COMP001',
      monthYear: DateTime.parse('2024-11-01'),
      vehicleFuelLitres: 130.43,
      gasHeatingKWh: 1111.11,
      electricityKWh: 525.00,
      employeeCommuteKm: 4550.00,
      paperUsageReams: 33,
      cloudUsageHours: 234.00,
    ),
    Emission(
      companyId: 'COMP001',
      monthYear: DateTime.parse('2024-12-01'),
      vehicleFuelLitres: 122.61,
      gasHeatingKWh: 1044.44,
      electricityKWh: 475.00,
      employeeCommuteKm: 4375.00,
      paperUsageReams: 32,
      cloudUsageHours: 225.00,
    ),
    Emission(
      companyId: 'COMP001',
      monthYear: DateTime.parse('2023-01-01'),
      vehicleFuelLitres: 150.32,
      gasHeatingKWh: 1200.33,
      electricityKWh: 1260.00,
      employeeCommuteKm: 5000.00,
      paperUsageReams: 61,
      cloudUsageHours: 432.00,
    ),
    Emission(
      companyId: 'COMP001',
      monthYear: DateTime.parse('2023-02-01'),
      vehicleFuelLitres: 244.18,
      gasHeatingKWh: 1000.00,
      electricityKWh: 1140.00,
      employeeCommuteKm: 5000.00,
      paperUsageReams: 59,
      cloudUsageHours: 414.00,
    ),
    Emission(
      companyId: 'COMP001',
      monthYear: DateTime.parse('2023-03-01'),
      vehicleFuelLitres: 286.96,
      gasHeatingKWh: 1100.33,
      electricityKWh: 1350.00,
      employeeCommuteKm: 5300.00,
      paperUsageReams: 67,
      cloudUsageHours: 468.00,
    ),
    Emission(
      companyId: 'COMP001',
      monthYear: DateTime.parse('2023-04-01'),
      vehicleFuelLitres: 222.26,
      gasHeatingKWh: 1893.33,
      electricityKWh: 1020.00,
      employeeCommuteKm: 5200.00,
      paperUsageReams: 56,
      cloudUsageHours: 396.00,
    ),
    Emission(
      companyId: 'COMP001',
      monthYear: DateTime.parse('2023-05-01'),
      vehicleFuelLitres: 212.87,
      gasHeatingKWh: 1813.33,
      electricityKWh: 960.00,
      employeeCommuteKm: 5350.00,
      paperUsageReams: 54,
      cloudUsageHours: 378.00,
    ),
    Emission(
      companyId: 'COMP001',
      monthYear: DateTime.parse('2023-06-01'),
      vehicleFuelLitres: 203.48,
      gasHeatingKWh: 1733.33,
      electricityKWh: 930.00,
      employeeCommuteKm: 6860.00,
      paperUsageReams: 50,
      cloudUsageHours: 352.80,
    ),
    Emission(
      companyId: 'COMP001',
      monthYear: DateTime.parse('2023-07-01'),
      vehicleFuelLitres: 194.09,
      gasHeatingKWh: 1653.33,
      electricityKWh: 870.00,
      employeeCommuteKm: 6440.00,
      paperUsageReams: 47,
      cloudUsageHours: 331.20,
    ),
    Emission(
      companyId: 'COMP001',
      monthYear: DateTime.parse('2023-08-01'),
      vehicleFuelLitres: 250.69,
      gasHeatingKWh: 1873.33,
      electricityKWh: 1100.00,
      employeeCommuteKm: 6230.00,
      paperUsageReams: 46,
      cloudUsageHours: 320.40,
    ),
    Emission(
      companyId: 'COMP001',
      monthYear: DateTime.parse('2023-09-01'),
      vehicleFuelLitres: 260.31,
      gasHeatingKWh: 2200.33,
      electricityKWh: 1300.00,
      employeeCommuteKm: 5950.00,
      paperUsageReams: 43,
      cloudUsageHours: 306.00,
    ),
    Emission(
      companyId: 'COMP001',
      monthYear: DateTime.parse('2023-10-01'),
      vehicleFuelLitres: 300.91,
      gasHeatingKWh: 2450.33,
      electricityKWh: 690.00,
      employeeCommuteKm: 5740.00,
      paperUsageReams: 42,
      cloudUsageHours: 295.20,
    ),
    Emission(
      companyId: 'COMP001',
      monthYear: DateTime.parse('2023-11-01'),
      vehicleFuelLitres: 300.52,
      gasHeatingKWh: 2000.33,
      electricityKWh: 630.00,
      employeeCommuteKm: 5460.00,
      paperUsageReams: 40,
      cloudUsageHours: 280.80,
    ),
    Emission(
      companyId: 'COMP001',
      monthYear: DateTime.parse('2023-12-01'),
      vehicleFuelLitres: 250.13,
      gasHeatingKWh: 3000.33,
      electricityKWh: 570.00,
      employeeCommuteKm: 5250.00,
      paperUsageReams: 38,
      cloudUsageHours: 270.00,
    ),
  ]..sort((a, b) => a.monthYear.compareTo(b.monthYear));
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
    final data = ref.watch(dashboardDataProvider);
    final netZeroProgress = ref.watch(netZeroProgressProvider);

    return Scaffold(
      body: ResponsivePadding(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              // Content
              _buildOverviewTab(data, netZeroProgress),
              // _buildProgressTab(data, netZeroProgress),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOverviewTab(List<Emission> data, double netZeroProgress) {
    final currentMonth = data.last;
    final previousMonth = data[data.length - 2];
    final monthlyChange =
        ((currentMonth.total - previousMonth.total) / previousMonth.total) *
        100;

    return Column(
      children: [
        // KPI Cards
        Row(
          children: [
            Expanded(
              child: _buildKPICard(
                '${currentMonth.monthYear.monthNameShort} ${currentMonth.monthYear.year} Emissions',
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
        YearlyChart(
          title: 'Emissions by Scope',
          chartBuilder: (context, data) {
            return Row(
              children: [
                Expanded(
                  child: PieChart(
                    PieChartData(
                      sections: _buildPieChartSections(data),
                      centerSpaceRadius: 64,
                      sectionsSpace: 0,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildScopeCard(
                      'Scope 1',
                      data.last.scope1,
                      AppColors.scope1,
                      'Direct emissions',
                    ),
                    const SizedBox(height: 24),
                    _buildScopeCard(
                      'Scope 2',
                      data.last.scope2,
                      AppColors.scope2,
                      'Indirect energy',
                    ),
                    const SizedBox(height: 24),
                    _buildScopeCard(
                      'Scope 3',
                      data.last.scope3,
                      AppColors.scope3,
                      'Value chain',
                    ),
                  ],
                ),
              ],
            );
          },
        ),

        const SizedBox(height: 16),

        YearlyChart(
          title: 'Scope Breakdown Monthly',
          chartBuilder: (context, data) {
            return BarChart(
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
                        if (value.toInt() >= 0 && value.toInt() < data.length) {
                          return Text(
                            data[value.toInt()].monthYear.monthNameShort,
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
                    // groupVertically: true,
                    barRods: [
                      BarChartRodData(
                        toY: entry.value.total,
                        color: Colors.grey,
                        width: 12,
                        rodStackItems: [
                          BarChartRodStackItem(
                            0,
                            entry.value.scope1,
                            AppColors.scope1,
                          ),
                          BarChartRodStackItem(
                            entry.value.scope1 + 4,
                            entry.value.scope1 + entry.value.scope2,
                            AppColors.scope2,
                          ),
                          BarChartRodStackItem(
                            entry.value.scope1 + entry.value.scope2 + 4,
                            entry.value.total,
                            AppColors.scope3,
                          ),
                        ],
                      ),
                    ],
                  );
                }).toList(),
              ),
            );
          },
        ),

        const SizedBox(height: 16),

        // Monthly Trend Line Chart
        YearlyChart(
          title: 'Yearly Emissions Trend',
          chartBuilder: (context, data) {
            return LineChart(
              LineChartData(
                gridData: FlGridData(show: true, drawVerticalLine: false),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 50,
                      minIncluded: false,
                      maxIncluded: false,
                      getTitlesWidget: (value, meta) => Text(
                        '${value.toInt()}',
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        if (value.toInt() >= 0 && value.toInt() < data.length) {
                          return SideTitleWidget(
                            meta: meta,
                            child: Text(
                              data[value.toInt()].monthYear.monthNameShort,
                              style: const TextStyle(fontSize: 10),
                            ),
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
                    color: AppColors.primary,
                    barWidth: 3,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      color: AppColors.primary.withOpacity(0.2),
                    ),
                  ),
                  LineChartBarData(
                    spots: data.asMap().entries.map((entry) {
                      return FlSpot(entry.key.toDouble(), entry.value.target);
                    }).toList(),
                    isCurved: true,
                    color: Theme.of(context).colorScheme.tertiary,
                    barWidth: 2,
                    dashArray: [5, 5],
                    dotData: const FlDotData(show: false),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildProgressTab(List<Emission> data, double netZeroProgress) {
    final targetYear = 2030;
    final currentYear = DateTime.now().year;
    final yearsRemaining = targetYear - currentYear;

    return Column(
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
    return Card.outlined(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade600,
              ),
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
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            const SizedBox(width: 8),
            Text(title, style: const TextStyle(fontSize: 14)),
          ],
        ),

        const SizedBox(height: 4),
        Text(
          description,
          style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
          textAlign: TextAlign.center,
        ),
      ],
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

  List<PieChartSectionData> _buildPieChartSections(List<Emission> data) {
    final scope1 =
        (data.fold(0.0, (prev, curr) => prev + curr.scope1)) / data.length;
    final scope2 =
        (data.fold(0.0, (prev, curr) => prev + curr.scope2)) / data.length;
    final scope3 =
        (data.fold(0.0, (prev, curr) => prev + curr.scope3)) / data.length;
    final total = scope1 + scope2 + scope3;

    return [
      PieChartSectionData(
        value: scope1,
        color: AppColors.scope1,
        title: '${((scope1 / total) * 100).toStringAsFixed(1)}%',
        radius: 100,
        titleStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      PieChartSectionData(
        value: scope2,
        color: AppColors.scope2,
        title: '${((scope2 / total) * 100).toStringAsFixed(1)}%',
        radius: 100,
        titleStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      PieChartSectionData(
        value: scope3,
        color: AppColors.scope3,
        title: '${((scope3 / total) * 100).toStringAsFixed(1)}%',
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
