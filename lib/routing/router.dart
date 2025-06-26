// create go router with a list of routes
// inital route is the home page
// create login and register routes
// create a route for the console page with subroutes for the dashboard, settings, and logs
// if the user is not authenticated, redirect to the login page
// add a route for the not found page

import 'package:carbon_root_analytics/config/dependencies.dart';
import 'package:carbon_root_analytics/features/auth/ui/login/view/login_view.dart';
import 'package:carbon_root_analytics/features/auth/ui/register/view/register_view.dart';
import 'package:carbon_root_analytics/features/company/ui/create_company/view/create_company_view.dart';
import 'package:carbon_root_analytics/features/navigation_console/view/pages/dashboard/dashboard_view.dart';
import 'package:carbon_root_analytics/features/navigation_console/view/navigation_console_view.dart.dart';
import 'package:carbon_root_analytics/features/navigation_console/view/pages/logs/logs_view.dart';
import 'package:carbon_root_analytics/features/offset/offset_view.dart';
import 'package:carbon_root_analytics/features/premium/view/premium_view.dart';
import 'package:carbon_root_analytics/features/reduction/reduction_view.dart';
import 'package:carbon_root_analytics/features/report/report_view.dart';
import 'package:carbon_root_analytics/routing/routes.dart';
import 'package:carbon_root_analytics/utils/ui/not_found_view.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:carbon_root_analytics/features/home/view/home_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// This is super important - otherwise, we would throw away the whole widget tree when the provider is updated.
final navigatorKey = GlobalKey<NavigatorState>();
final shellKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  final isAuthenticated = ref.watch(authStateProvider).valueOrNull != null;

  return GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: isAuthenticated ? Routes.consoleDashboard : Routes.home,
    redirect: (context, state) {
      final isLoginPage = state.fullPath?.contains(Routes.login) ?? false;
      final isRegisterPage = state.fullPath?.contains(Routes.register) ?? false;
      final isHomePage = state.fullPath == Routes.home;

      if (isAuthenticated && (isLoginPage || isRegisterPage)) {
        return Routes.consoleDashboard;
      }
      if (!isAuthenticated && !isLoginPage && !isRegisterPage && !isHomePage) {
        return Routes.login;
      }

      return null;
    },
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
            path: Routes.loginRelative,
            builder: (context, state) => const LoginView(),
          ),
          GoRoute(
            path: Routes.registerRelative,
            builder: (context, state) => const RegisterView(),
          ),

          GoRoute(
            path: Routes.createCompanyRelative,
            builder: (context, state) => const CreateCompanyView(),
          ),

          ShellRoute(
            parentNavigatorKey: navigatorKey,
            navigatorKey: shellKey,
            builder: (context, state, child) {
              return NavigationConsole(child);
            },
            routes: [
              GoRoute(
                path: Routes.consoleDashboard,
                builder: (context, state) => const DashboardView(),
              ),
              GoRoute(
                path: Routes.consoleLogs,
                builder: (context, state) => const CompanyDetailsView(),
              ),
              GoRoute(
                path: Routes.consoleReduction,
                builder: (context, state) => const ReductionInitiativesPage(),
              ),
              GoRoute(
                path: Routes.consoleOffset,
                builder: (context, state) => const OffsetView(),
              ),
              GoRoute(
                path: Routes.consoleReport,
                builder: (context, state) => const GenerateReportTab(),
              ),
              GoRoute(
                path: Routes.consolePremium,
                builder: (context, state) => const PremiumView(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
