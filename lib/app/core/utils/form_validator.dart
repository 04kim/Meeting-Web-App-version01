// ignore_for_file: unnecessary_null_comparison

class FormValidator {
  static String? validateName(String value) {
    if (value.isEmpty) {
      return 'ກະລຸນາປ້ອນຊື່ອົງກອນ';
    }
    return null;
  }

  static String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'ກະລຸນາປ້ອນລະຫັດຜ່ານ';
    } else if (value.length < 6) {
      return 'ລະຫັດຜ່ານຕ້ອງມີຢ່າງໜ້ອຍ6ໂຕອັກສອນ';
    }
    return null;
  }

  static String? validateConfirmPassword(String password, String value) {
    if (value.isEmpty) {
      return 'ກະລຸນະຍືນຍັນລະຫັດຜ່ານ';
    } else if (value != password) {
      return 'ລະຫັດຜ່ານບໍ່ຕົງ';
    }
    return null;
  }

  static String? validateEmail(String value) {
    if (value.isEmpty) {
      return 'ກະລຸນາປ້ອນທີ່ຢູ່ອີເມລ';
    } else if (!isEmailValid(value)) {
      return 'ກະລຸນາປ້ອນທີ່ຢູ່ອີເມລທີ່ຖືກຕ້ອງ';
    }
    return null;
  }

  static bool isEmailValid(String email) {
    final emailRegExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegExp.hasMatch(email);
  }

  static String? validateConfirmCode(String value) {
    if (value.isEmpty) {
      return 'ກະລຸນາປ້ອນລະຫັດຍືນຍັນ';
    } else if (!isNumeric(value)) {
      return 'ລະຫັດຍືນຍັນຄວນເປັນເລກຕົວເລກ';
    }
    return null;
  }

  static bool isNumeric(String value) {
    if (value == null) {
      return false;
    }
    return double.tryParse(value) != null;
  }
}
