abstract final class Routes {
  static const home = '/';
  static const loginRelative = 'login';
  static const login = '/$loginRelative';
  static const registerRelative = 'register';
  static const register = '/$registerRelative';
  static const notFoundRelative = 'not-found';
  static const notFound = '/$notFoundRelative';

  // company routes
  static const createCompanyRelative = 'create-company';
  static const createCompany = '/$createCompanyRelative';

  // Console routes
  static const _console = '/console';
  static const consoleDashboard = '$_console/dashboard';
  static const consoleLogs = '$_console/logs';
  static const consoleReduction = '$_console/reduction';
  static const consoleOffset = '$_console/offset';
  static const consoleReport = '$_console/report';
  static const consolePremium = '$_console/premium';
}
