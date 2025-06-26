import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:carbon_root_analytics/features/navigation_console/model/destination.dart';

class CustomNavRail extends ConsumerWidget {
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  const CustomNavRail({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: 72,
      child: NavigationRail(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
        groupAlignment: 0.0,
        selectedIndex: selectedIndex,
        onDestinationSelected: onDestinationSelected,
        destinations: myDestinations.map((d) {
          return NavigationRailDestination(
            icon: Icon(d.icon),
            label: Text(d.label),
          );
        }).toList(),
        // trailing: Column(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     const SizedBox(),
        //     IconButton(
        //       onPressed: () {
        //         ref.read(themeControllerProvider.notifier).toggleThemeMode();
        //       },
        //       icon: const Icon(Icons.wb_sunny_outlined),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
