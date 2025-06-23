import 'package:carbon_root_analytics/config/dependencies.dart';
import 'package:carbon_root_analytics/features/auth/ui/logout/view_model/logout_view_model.dart';
import 'package:carbon_root_analytics/utils/theme/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:carbon_root_analytics/features/navigation_console/model/destination.dart';

class CustomDrawer extends HookConsumerWidget {
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  const CustomDrawer({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<LogoutState>(logoutViewModelProvider, (previous, next) {
      if (next.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.errorMessage!),
            backgroundColor: Colors.red,
          ),
        );
      }
    });
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
        // logout button
        Consumer(
          builder: (context, ref, child) {
            return ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 28),
              leading: const Icon(Icons.logout_outlined),
              title: const Text('Logout'),
              onTap: () {
                // show confirmation dialog
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Logout'),
                      content: const Text('Are you sure you want to logout?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            // Trigger the logout action
                            ref.read(logoutViewModelProvider.notifier).logout();
                          },
                          child: const Text('Logout'),
                        ),
                      ],
                    );
                  },
                );
              },

              // Handle logout
            );
          },
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(28, 8, 28, 8),
          child: Divider(),
        ),
        // toggle theme button
        Consumer(
          builder: (context, ref, child) {
            final mode = ref.watch(themeControllerProvider);
            return ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 28),
              leading: const Icon(Icons.wb_sunny_outlined),
              title: const Text('Dark Mode'),
              trailing: Switch(
                value: mode == ThemeMode.dark,
                onChanged: (value) {
                  // Handle theme toggle
                  ref.read(themeControllerProvider.notifier).toggleThemeMode();
                },
              ),
              onTap: () {
                ref.read(themeControllerProvider.notifier).toggleThemeMode();
              },
            );
          },
        ),
      ],
    );
  }
}
