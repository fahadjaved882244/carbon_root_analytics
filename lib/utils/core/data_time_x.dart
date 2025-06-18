extension DataTimeX on DateTime {
  String get monthName => [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ][month - 1];

  String get monthNameShort => monthName.substring(0, 3);
}
