import 'package:flutter/material.dart';

void showSignUpSuccessDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('ສ້າງບັນຊີສຳເລັດ'),
        content: Text('ບັນຊີຂອງທ່ານໄດ້ຖືກສ້າງແລ້ວ.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}

void showSentPasswordSuccessDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('ສົ່ງລະຫັດຜ່ານແລ້ວ'),
        content: Text(
            'ກວດສອບອີເມລຂອງທ່ານເພື່ອຣີເຊັດລະຫັດຜ່ານ ແລະ ລັອກອິນດ້ວຍລະຫັດຜ່ານໃໝ່!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}

void showChangedPasswordSuccessDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('ປ່ຽນລະຫັດຜ່ານແລ້ວ'),
        content: Text('ລະຫັດຜ່ານຂອງທ່ານໄດ້ຖືກປ່ຽນແປງສຳເລັດ!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}

void showErrorSnackBar1(BuildContext context, String message,
    {Color backgroundColor = Colors.black}) {
  ScaffoldMessenger.of(context).showSnackBar(
    ErrorSnackBar1(
      message: message,
      backgroundColor: backgroundColor,
    ),
  );
}

void showErrorSnackBar2(BuildContext context, String message,
    {Color backgroundColor = Colors.black}) {
  ScaffoldMessenger.of(context).showSnackBar(
    ErrorSnackBar2(
      message: message,
      backgroundColor: backgroundColor,
    ),
  );
}

class ErrorSnackBar1 extends SnackBar {
  ErrorSnackBar1({
    Key? key,
    required String message,
    Color backgroundColor = Colors.black,
    TextStyle contentTextStyle =
        const TextStyle(fontSize: 16, color: Colors.white),
  }) : super(
          key: key,
          backgroundColor: backgroundColor,
          content: Text(
            message,
            style: contentTextStyle,
          ),
          behavior: SnackBarBehavior.fixed,
          duration: Duration(seconds: 4),
        );
}

class ErrorSnackBar2 extends SnackBar {
  ErrorSnackBar2({
    Key? key,
    required String message,
    Color backgroundColor = Colors.black,
    TextStyle contentTextStyle =
        const TextStyle(fontSize: 16, color: Colors.white),
  }) : super(
          key: key,
          backgroundColor: backgroundColor,
          content: Text(
            message,
            style: contentTextStyle,
          ),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 4),
        );
}

void showChangedNameSuccessDialog(BuildContext context, String newName) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('ປ່ຽນຊື່ອົງກອນແລ້ວ'),
        content: Text('ຊື່ອົງກອນຂອງທ່ານໄດ້ຖືກປ່ຽນຮຽບຮ້ອຍ!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}

void showChangedCodeSuccessDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('ບັນທຶກລະຫັດຜ່ານໜ້າຈໍແລ້ວ'),
        content: Text('ລະຫັດຜ່ານໜ້າຈໍຂອງທ່ານໄດ້ຖືກບັນທຶກແລ້ວ!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}

void showChangedPassWordSuccessDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('ປ່ຽນລະຫັດຜ່ານແລ້ວ'),
        content: Text('ລະຫັດຜ່ານຂອງທ່ານໄດ້ຖືກປ່ຽນຮຽບຮ້ອຍ!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}
