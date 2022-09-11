extension StringExtension on String {
  DateTime toDateTime() {
    return DateTime.parse(this);
  }
}

extension DateTimeExtension on DateTime {
  String toFormattedString() {

    List<String> months = ['Ocak', 'Şubat', 'Mart', 'Nisan', 'Mayıs', 'Haziran', 'Temmuz', 'Ağustos', 'Eylül', 'Ekim', 'Kasım', 'Aralık'];
    return '$day ${months[month-1]} $year';
  }
}