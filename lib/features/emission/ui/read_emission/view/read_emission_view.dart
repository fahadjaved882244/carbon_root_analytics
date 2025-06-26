import 'package:carbon_root_analytics/features/emission/domain/carbon_emission.dart';
import 'package:carbon_root_analytics/features/emission/ui/read_emission/view/widgets/yearly_chart.dart';
import 'package:carbon_root_analytics/features/emission/ui/read_emission/view_model/read_emission_view_model.dart';
import 'package:carbon_root_analytics/features/navigation_console/view/widgets/responsive_padding.dart';
import 'package:carbon_root_analytics/utils/core/data_time_x.dart';
import 'package:carbon_root_analytics/utils/core/media_query_x.dart';
import 'package:carbon_root_analytics/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math' as math;

class CarbonDashboardView extends HookConsumerWidget {
  final String companyId;

  const CarbonDashboardView({super.key, required this.companyId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dataState = ref.watch(readEmissionViewModelProvider);

    return Scaffold(
      body: ResponsivePadding(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: dataState.when(
            data: (data) {
              if (data.isEmpty) {
                return Center(
                  child: Text(
                    'No emissions data available for this company.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                );
              }
              final currentEmissions = data.last.totalEmissions;
              const baselineEmissions = 2470.0; // January baseline
              final progress =
                  ((baselineEmissions - currentEmissions) / baselineEmissions) *
                  100;
              final netZeroProgress = math.max(0, math.min(100, progress));
              return _buildOverviewTab(
                context,
                data,
                netZeroProgress.toDouble(),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(
              child: Text(
                'Error loading emissions data: $error',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.red),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOverviewTab(
    BuildContext context,
    List<CarbonEmission> data,
    double netZeroProgress,
  ) {
    final currentMonth = data.last;
    final previousMonth = data[data.length - 2];
    final monthlyChange =
        ((currentMonth.totalEmissions - previousMonth.totalEmissions) /
            previousMonth.totalEmissions) *
        100;

    return Column(
      children: [
        // KPI Cards
        Row(
          children: [
            Expanded(
              child: _buildKPICard(
                context,
                '${currentMonth.monthYear.monthNameShort} ${currentMonth.monthYear.year} Emissions',
                '${currentMonth.totalEmissions.toStringAsFixed(0)} tCO₂e',
                monthlyChange < 0 ? Icons.trending_down : Icons.trending_up,
                monthlyChange < 0 ? Colors.green : Colors.red,
                '${monthlyChange.toStringAsFixed(1)}% vs last month',
                true,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildKPICard(
                context,
                'Net Zero Progress',
                '${netZeroProgress.toStringAsFixed(1)}%',
                Icons.eco,
                Colors.green,
                'Towards carbon neutrality',
                false,
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        // Scope Breakdown Pie Chart
        YearlyChart(
          title: 'Emissions by Scope',
          allData: data,
          chartBuilder: (context, data) {
            return Row(
              children: [
                Expanded(
                  child: PieChart(
                    PieChartData(
                      sections: _buildPieChartSections(context, data),
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
                      data.last.scope1Emissions,
                      AppColors.scope1,
                      'Direct emissions',
                    ),
                    const SizedBox(height: 24),
                    _buildScopeCard(
                      'Scope 2',
                      data.last.scope2Emissions,
                      AppColors.scope2,
                      'Indirect energy',
                    ),
                    const SizedBox(height: 24),
                    _buildScopeCard(
                      'Scope 3',
                      data.last.scope3Emissions,
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
          allData: data,
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
                      getTitlesWidget: (value, meta) => SideTitleWidget(
                        meta: meta,
                        child: Text(
                          '${value.toInt()}',
                          style: const TextStyle(fontSize: 10),
                        ),
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
                        toY: entry.value.totalEmissions,
                        color: Colors.grey,
                        width: 12,
                        rodStackItems: [
                          BarChartRodStackItem(
                            0,
                            entry.value.scope1Emissions,
                            AppColors.scope1,
                          ),
                          BarChartRodStackItem(
                            entry.value.scope1Emissions + 4,
                            entry.value.scope1Emissions +
                                entry.value.scope2Emissions,
                            AppColors.scope2,
                          ),
                          BarChartRodStackItem(
                            entry.value.scope1Emissions +
                                entry.value.scope2Emissions +
                                4,
                            entry.value.totalEmissions,
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
          title: 'Monthly Emissions Trend',
          allData: data,
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
                      getTitlesWidget: (value, meta) => SideTitleWidget(
                        meta: meta,
                        child: Text(
                          '${value.toInt()}',
                          style: const TextStyle(fontSize: 10),
                        ),
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
                      return FlSpot(
                        entry.key.toDouble(),
                        entry.value.totalEmissions,
                      );
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
                  // LineChartBarData(
                  //   spots: data.asMap().entries.map((entry) {
                  //     return FlSpot(
                  //       entry.key.toDouble(),
                  //       entry.value.targetEmissions,
                  //     );
                  //   }).toList(),
                  //   isCurved: true,
                  //   color: Theme.of(context).colorScheme.tertiary,
                  //   barWidth: 2,
                  //   dashArray: [5, 5],
                  //   dotData: const FlDotData(show: false),
                  // ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildProgressTab(List<CarbonEmission> data, double netZeroProgress) {
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
                '${(data.first.totalEmissions - data.last.totalEmissions).toStringAsFixed(0)} tCO₂e',
                Icons.trending_down,
                Colors.green,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildProgressMetric(
                'Monthly Reduction',
                '${((data.first.totalEmissions - data.last.totalEmissions) / data.length).toStringAsFixed(0)} tCO₂e',
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
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color color,
    String subtitle,
    bool isPrimary,
  ) {
    return Card.filled(
      color: isPrimary ? Theme.of(context).colorScheme.primary : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: isPrimary
            ? BorderSide.none
            : BorderSide(color: Colors.grey.shade300, width: 1.0),
      ),
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
                      color: isPrimary
                          ? Theme.of(context).colorScheme.onPrimary
                          : Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isPrimary
                    ? Theme.of(context).colorScheme.onPrimary
                    : Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12,
                color: isPrimary
                    ? Theme.of(context).colorScheme.onPrimary
                    : Colors.grey.shade600,
              ),
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

  List<PieChartSectionData> _buildPieChartSections(
    BuildContext context,
    List<CarbonEmission> data,
  ) {
    final scope1 =
        (data.fold(0.0, (prev, curr) => prev + curr.scope1Emissions)) /
        data.length;
    final scope2 =
        (data.fold(0.0, (prev, curr) => prev + curr.scope2Emissions)) /
        data.length;
    final scope3 =
        (data.fold(0.0, (prev, curr) => prev + curr.scope3Emissions)) /
        data.length;
    final total = scope1 + scope2 + scope3;

    return [
      PieChartSectionData(
        value: scope1,
        color: AppColors.scope1,
        title: '${((scope1 / total) * 100).toStringAsFixed(1)}%',
        radius: context.isPhone ? 48 : 100,
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
        radius: context.isPhone ? 48 : 100,
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
        radius: context.isPhone ? 48 : 100,
        titleStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ];
  }
}
