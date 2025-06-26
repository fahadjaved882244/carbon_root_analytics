import 'package:carbon_root_analytics/features/emission/domain/carbon_emission.dart';
import 'package:carbon_root_analytics/features/emission/ui/read_emission/view_model/read_emission_view_model.dart';
import 'package:carbon_root_analytics/utils/core/data_time_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EmissionExpansionPanel extends HookConsumerWidget {
  const EmissionExpansionPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emissions = ref.watch(readEmissionViewModelProvider);

    return emissions.when(
      loading: () => const ListTile(title: Text('Loading emissions data...')),
      error: (error, stack) =>
          ListTile(title: Text('Error loading emissions data: $error')),
      data: (emissions) {
        if (emissions.isEmpty) {
          return const ListTile(title: Text('No emissions data available'));
        }
        final groupedByYear = <int, List<CarbonEmission>>{};

        for (var emission in emissions) {
          final year = emission.monthYear.year;
          groupedByYear.putIfAbsent(year, () => []);
          groupedByYear[year]?.add(emission);
        }
        final emissionGroup = groupedByYear.entries.toList();
        return _EmissionExpansionPanelItem(emissionGroup: emissionGroup);
      },
    );
  }
}

class _EmissionExpansionPanelItem extends HookConsumerWidget {
  final List<MapEntry<int, List<CarbonEmission>>> emissionGroup;
  const _EmissionExpansionPanelItem({required this.emissionGroup});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isExpandedList = useState<List<bool>>(
      List.generate(emissionGroup.length, (_) => false),
    );

    return SingleChildScrollView(
      child: ExpansionPanelList(
        elevation: 0,
        expansionCallback: (index, isExpanded) {
          isExpandedList.value = List.generate(
            emissionGroup.length,
            (i) => i == index ? isExpanded : isExpandedList.value[i],
          );
        },
        children: emissionGroup.map((entry) {
          final year = entry.key;
          final emissions = entry.value;

          return ExpansionPanel(
            isExpanded: isExpandedList.value[emissionGroup.indexOf(entry)],
            headerBuilder: (context, isExpanded) {
              return ListTile(
                selected: isExpanded,
                title: Text(
                  'Year $year',
                  style: TextStyle(
                    fontWeight: isExpanded
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              );
            },
            body: SizedBox(
              height: 232, // Set a fixed height for the grid
              child: GridView.builder(
                itemCount: emissions.length,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 100,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemBuilder: (context, index) {
                  final emission = emissions[index];
                  return Card.filled(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    child: Center(
                      child: Text(
                        emission.monthYear.monthNameShort,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Theme.of(
                            context,
                          ).colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
