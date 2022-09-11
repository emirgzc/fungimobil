extension StringExtension on String {
  DateTime toDateTime() {
    return DateTime.parse(this);
  }

  /// convert raw data to number format
  String toNumberFormat({bool isDeleting = false}) {
    if (this != '.' && double.tryParse(this) == null) {
      return '';
    }

    // String rawString = numberToRawFormat();
    var rawSplitList = split('.');
    String integerSection = split('.')[0];
    String decimalSection = rawSplitList.length > 1 ? split('.')[1] : '';

    String result = '';
    for (int i = 0; i < integerSection.length; i++) {
      if (i != 0 && (integerSection.length - i) % 3 == 0) {
        result += '.' + integerSection[i];
      } else {
        result += integerSection[i];
      }
    }

    if (contains('.')) {
      result += ',';
    }

    for (int i = 0; i < decimalSection.length && i < 2; i++) {
      result += decimalSection[i];
    }

    if (decimalSection == '0' && !isDeleting) {
      result += '0';
    }

    if (decimalSection == '') {
      result += ',00';
    }

    return result;
  }

  String numberToRawFormat() {
    String doubleFormat = split(' ')[0].replaceAll('.', '').replaceAll(',', '.');
    List<String> doubleSplitList = doubleFormat.split('.');
    String result = doubleSplitList[0] + (doubleSplitList.length > 1 ? '.' + doubleSplitList[1] : '');
    // result = double.tryParse(result) != null ? result : '';
    return result;
  }
}

extension DateTimeExtension on DateTime {
  String toFormattedString() {
    List<String> months = ['Ocak', 'Şubat', 'Mart', 'Nisan', 'Mayıs', 'Haziran', 'Temmuz', 'Ağustos', 'Eylül', 'Ekim', 'Kasım', 'Aralık'];
    return '$day ${months[month-1]} $year';
  }

  String toFormattedStringWithTime(){
    return '${toFormattedString()} - $hour:$minute';
  }
}