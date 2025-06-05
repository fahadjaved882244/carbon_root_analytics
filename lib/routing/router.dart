// create go router with a list of routes
// inital route is the home page
// create login and register routes
// create a route for the console page with subroutes for the dashboard, settings, and logs
// if the user is not authenticated, redirect to the login page
// add a route for the not found page

import 'package:carbon_root_analytics/features/auth/ui/login/view/login_view.dart';
import 'package:carbon_root_analytics/routing/routes.dart';
import 'package:carbon_root_analytics/utils/ui/not_found_view.dart';
import 'package:go_router/go_router.dart';
import 'package:carbon_root_analytics/features/home/view/home_view.dart';

// import 'package:carbon_root_analytics/features/auth/view/login_view.dart';
// import 'package:carbon_root_analytics/features/auth/view/register_view.dart';
// import 'package:carbon_root_analytics/features/console/view/console_view.dart';
// import 'package:carbon_root_analytics/features/console/view/dashboard_view.dart';
// import 'package:carbon_root_analytics/features/console/view/settings_view.dart';
// import 'package:carbon_root_analytics/features/console/view/logs_view.dart';
// import 'package:carbon_root_analytics/features/not_found/view/not_found_view.dart';
// import 'package:carbon_root_analytics/features/auth/services/auth_service.dart';
// import 'package:carbon_root_analytics/features/auth/services/auth_guard.dart';
final GoRouter router = GoRouter(
  initialLocation: Routes.home,
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
