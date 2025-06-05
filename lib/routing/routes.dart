abstract final class Routes {
  static const home = '/';
  static const login = '/login';
  static const register = '/register';
  static const notFoundRelative = 'not-found';
  static const notFound = '/$notFoundRelative';

  static const consoleRelative = 'console';
  static const console = '/$consoleRelative';
  static const consoleDashboardRelative = 'dashboard';
  static const consoleDashboard = '$console/$consoleDashboardRelative';
  static const consoleSettingsRelative = 'settings';
  static const consoleSettings = '$console/$consoleSettingsRelative';
  static const consoleLogsRelative = 'logs';
  static const consoleLogs = '$console/$consoleLogsRelative';
}
