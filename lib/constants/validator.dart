class Validator {
  Validator._();

  static String? emptyValidator(String? s) {
    return null;
  }

  static String? requiredTextValidator(String? s) {
    if (s == null || s.isEmpty) {
      return 'Bu alan boş bırakılamaz';
    }
    return null;
  }

  static String? phoneValidator(String? s) {
    if (s == null || s.isEmpty) {
      return 'Bu alan boş bırakılamaz';
    } else if (s.length != 19) {
      return 'Lütfen geçerli bir telefon numarası giriniz';
    }
    return null;
  }

  static String? emailValidator(String? s) {
    var regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (s == null || s.isEmpty) {
      return 'Bu alan boş bırakılamaz';
    } else if (!regex.hasMatch(s)) {
      return 'Lütfen geçerli bir e-posta adresi giriniz';
    }
    return null;
  }

  static String? passwordValidator(String? s) {
    if (s == null || s.isEmpty) {
      return 'Bu alan boş bırakılamaz';
    } else if (s.trim().length < 6) {
      return 'Parolanız en az 6 karakterden oluşlamılıdır';
    }
    return null;
  }
}
