import 'package:carbon_root_analytics/utils/theme/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:carbon_root_analytics/features/responsive/model/destination.dart';

class CustomDrawer extends ConsumerWidget {
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  const CustomDrawer({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NavigationDrawer(
      selectedIndex: selectedIndex,
      onDestinationSelected: (i) {
        onDestinationSelected(i);
        // close the drawer if open
        if (Scaffold.of(context).isDrawerOpen) {
          Scaffold.of(context).closeDrawer();
        }
      },
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.fromLTRB(28, 16, 16, 10),
          child: SizedBox(),
        ),
        ...myDestinations.map((destination) {
          return NavigationDrawerDestination(
            label: Text(destination.label),
            icon: Icon(destination.icon),
          );
        }),
        const Padding(
          padding: EdgeInsets.fromLTRB(28, 8, 28, 8),
          child: Divider(),
        ),
        // toggle theme button
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 28),
          leading: const Icon(Icons.wb_sunny_outlined),
          title: const Text('Dark Mode'),
          trailing: Switch(
            value:
                ref.watch(themeControllerProvider.notifier).themeMode ==
                ThemeMode.dark,
            onChanged: (value) {
              // Handle theme toggle
              ref.read(themeControllerProvider.notifier).toggleThemeMode();
            },
          ),
          onTap: () {
            ref.read(themeControllerProvider.notifier).toggleThemeMode();
          },
        ),
      ],
    );
  }
}
