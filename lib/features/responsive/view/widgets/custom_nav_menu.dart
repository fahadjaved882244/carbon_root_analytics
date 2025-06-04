import 'package:carbon_root_analytics/utils/theme/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:carbon_root_analytics/features/responsive/model/destination.dart';

class CustomNavMenu extends ConsumerWidget {
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  const CustomNavMenu({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainer,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Logo
            Text(
              'Portfolio',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            // Navigation Menu
            Row(
              children: [
                ...myDestinations.map(
                  (d) => _MenuItem(
                    title: d.label,
                    index: myDestinations.indexOf(d),
                    selectedIndex: selectedIndex,
                    onDestinationSelected: onDestinationSelected,
                  ),
                ),

                const SizedBox(width: 32),
                // Theme Toggle Button
                IconButton(
                  onPressed: () {
                    ref
                        .read(themeControllerProvider.notifier)
                        .toggleThemeMode();
                  },
                  icon: const Icon(Icons.wb_sunny_outlined),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuItem extends HookConsumerWidget {
  final String title;
  final int index;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  const _MenuItem({
    required this.title,
    required this.index,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hoveredIndex = useState(-1);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        hoveredIndex.value = index;
      }, // Optional: Handle hover logic
      onExit: (_) {
        hoveredIndex.value = -1;
      },
      child: GestureDetector(
        onTap: () => onDestinationSelected(index),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(vertical: 2),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: selectedIndex == index
                      ? Theme.of(context).colorScheme.primary
                      : Colors.transparent,
                  width: 2,
                ),
              ),
            ),
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: selectedIndex == index
                    ? Theme.of(context).colorScheme.primary
                    : hoveredIndex.value == index
                    ? Theme.of(context).colorScheme.tertiary
                    : Theme.of(context).colorScheme.onSurface,
                fontWeight: selectedIndex == index
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
