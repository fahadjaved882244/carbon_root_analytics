import 'package:carbon_root_analytics/features/emission/domain/carbon_emission.dart';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class YearlyChart extends HookConsumerWidget {
  final String title;
  final List<CarbonEmission> allData;
  final Widget Function(BuildContext context, List<CarbonEmission> data)
  chartBuilder;
  const YearlyChart({
    super.key,
    required this.title,
    required this.allData,
    required this.chartBuilder,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // calculate which years data is there
    final years = allData.map((e) => e.monthYear.year).toSet().toList()
      ..sort((a, b) => b.compareTo(a)); // Sort descending

    final selectedYear = useState(
      years.isNotEmpty ? years.first : DateTime.now().year,
    );
    final data = allData
        .where((d) => d.monthYear.year == selectedYear.value)
        .toList();

    return Card.outlined(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                DropdownButton<int>(
                  value: selectedYear.value,
                  items: years
                      .map(
                        (year) => DropdownMenuItem<int>(
                          value: year,
                          child: Text(year.toString()),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      selectedYear.value = value;
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 350,
              child: data.isEmpty
                  ? const Center(child: Text('No data available for this year'))
                  : chartBuilder(context, data),
            ),
          ],
        ),
      ),
    );
  }
}
