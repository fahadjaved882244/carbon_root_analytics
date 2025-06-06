// create go router with a list of routes
// inital route is the home page
// create login and register routes
// create a route for the console page with subroutes for the dashboard, settings, and logs
// if the user is not authenticated, redirect to the login page
// add a route for the not found page

import 'package:carbon_root_analytics/features/auth/ui/login/view/login_view.dart';
import 'package:carbon_root_analytics/features/dashboard/ui/view/dashboard_view.dart';
import 'package:carbon_root_analytics/features/navigation_console/view/navigation_console_view.dart.dart';
import 'package:carbon_root_analytics/routing/routes.dart';
import 'package:carbon_root_analytics/utils/ui/not_found_view.dart';
import 'package:go_router/go_router.dart';
import 'package:carbon_root_analytics/features/home/view/home_view.dart';

GoRouter router(bool isAuthenticated) => GoRouter(
  initialLocation: isAuthenticated ? Routes.consoleDashboard : Routes.home,
  // redirect: (context,state) {
  //   final isAuthenticated = AuthService.isAuthenticated();
  //   final isLoginPage = state.subloc == '/login';
  //   final isRegisterPage = state.subloc == '/register';

  //   if (!isAuthenticated && !isLoginPage && !isRegisterPage) {
  //     return '/login';
  //   }
  //   return null;
  // },
  errorBuilder: (context, state) => const PageNotFoundView(),

  routes: [
    GoRoute(
      path: Routes.home,
      builder: (context, state) => const HomeView(),
      routes: [
        GoRoute(
          path: Routes.notFoundRelative,
          builder: (context, state) => const PageNotFoundView(),
        ),

        GoRoute(
          path: Routes.login,
          builder: (context, state) => const LoginView(),
        ),

        ShellRoute(
          builder: (context, state, child) {
            return NavigationConsole(child);
          },
          redirect: (context, state) {
            if (!isAuthenticated) {
              return Routes.login;
            }
            return null;
          },
          routes: [
            GoRoute(
              path: Routes.consoleDashboard,
              builder: (context, state) => const DashboardView(),
            ),
            GoRoute(
              path: Routes.consoleSettings,
              builder: (context, state) => const DashboardView(),
            ),
            GoRoute(
              path: Routes.consoleLogs,
              builder: (context, state) => const DashboardView(),
            ),
          ],
        ),
      ],
    ),

    // GoRoute(
    //   path: '/register',
    //   builder: (context, state) => const RegisterView(),
    // ),
    // GoRoute(
    //   path: '/console',
    //   builder: (context, state) => const ConsoleView(),
    //   routes: [
    //     GoRoute(
    //       path: 'dashboard',
    //       builder: (context, state) => const DashboardView(),
    //     ),
    //     GoRoute(
    //       path: 'settings',
    //       builder: (context, state) => const SettingsView(),
    //     ),
    //     GoRoute(
    //       path: 'logs',
    //       builder: (context, state) => const LogsView(),
    //     ),
    //   ],
    // ),
  ],
);
