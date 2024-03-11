import 'package:flutter/material.dart';

Widget buildClearSuffixIcon(
  TextEditingController controller,
  VoidCallback onPressed,
) {
  return GestureDetector(
    onTap: () {
      controller.clear();
      onPressed();
    },
    child: IconButton(
      icon: Icon(Icons.clear),
      onPressed: null,
    ),
  );
}

Widget buildVisibilitySuffixIcon(
  bool isPasswordVisible,
  VoidCallback onPressed,
) {
  return GestureDetector(
    onTap: onPressed,
    child: Icon(
      isPasswordVisible ? Icons.visibility : Icons.visibility_off,
    ),
  );
}

Widget backButton() {
  return Tooltip(
    message: 'ກັບຄືນໜ້າເກົ່າ',
    child: BackButton(),
  );
}

String? confirmCodeError;
Widget buildErrorText(String? errorText) {
  // errorText = 'ລະຫັດຍືນຍັນບໍ່ຖືກຕ້ອງ';
  return errorText != null
      ? Text(
          errorText,
          style: TextStyle(color: Colors.red),
        )
      : SizedBox.shrink();
}
