import 'package:carbon_root_analytics/features/navigation_console/utils/media_query_extension.dart';
import 'package:carbon_root_analytics/features/navigation_console/view/widgets/custom_drawer.dart';
import 'package:carbon_root_analytics/features/navigation_console/view/widgets/custom_nav_rail.dart';
import 'package:carbon_root_analytics/features/navigation_console/view/widgets/search_app_bar.dart';
import 'package:carbon_root_analytics/routing/routes.dart';
import 'package:carbon_root_analytics/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationConsole extends StatelessWidget {
  final Widget child;
  const NavigationConsole(this.child, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
      appBar: !context.showRail
          ? AppBar(
              backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
              centerTitle: false,
              // title: Text(
              //   'CRA Console',
              //   style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
            )
          : SearchAppBar(),
      drawer: CustomDrawer(
        selectedIndex: _calculateSelectedIndex(context),
        onDestinationSelected: (i) {
          _onItemTapped(context, i);
        },
      ),
      body: SafeArea(
        child: Row(
          children: [
            if (context.showRail)
              CustomNavRail(
                selectedIndex: _calculateSelectedIndex(context),
                onDestinationSelected: (i) {
                  _onItemTapped(context, i);
                },
              ),
            Expanded(
              child: ClipRRect(
                borderRadius: context.showRail
                    ? const BorderRadius.horizontal(left: Radius.circular(24))
                    : BorderRadius.zero,
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    if (location.startsWith(Routes.consoleDashboard)) {
      return 0;
    } else if (location.startsWith(Routes.consoleLogs)) {
      return 1;
    } else if (location.startsWith(Routes.consoleOffset)) {
      return 2;
    }
    return 0;
  }

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go(Routes.consoleDashboard);
        break;
      case 1:
        context.go(Routes.consoleLogs);
        break;
      case 2:
        context.go(Routes.consoleOffset);
        break;
    }
  }
}
