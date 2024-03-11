import 'package:flutter/material.dart';
import 'package:meeting_app/app/share/states.dart';
import 'package:meeting_app/app/core/utils/form_validator.dart';

class ChangePasswordDialog {
  final ChangePasswordFormState state;
  final Function(String) onSave;
  final String? oldPasswordError;
  final String? newPasswordError;
  final String? confirmNewPasswordError;

  final String? errorMessage;

  ChangePasswordDialog({
    required this.state,
    required this.onSave,
    this.oldPasswordError,
    this.newPasswordError,
    this.confirmNewPasswordError,
    this.errorMessage,
  });
  void show(BuildContext context) {
    final TextEditingController _oldPassworldController =
        TextEditingController();
    final TextEditingController _newPassworldController =
        TextEditingController();
    final TextEditingController _confirmNewPassworldController =
        TextEditingController();

    String? oldPasswordError;
    String? newPasswordError;
    String? confirmNewPasswordError;

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.4,
            height: MediaQuery.of(context).size.height * 0.8,
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      errorMessage!,
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.close),
                    ),
                  ],
                ),
                SizedBox(height: 18.0),
                Text(
                  'ລະຫັດຜ່ານ',
                  style: TextStyle(fontSize: 22),
                ),
                SizedBox(height: 8),
                Text(
                  'ປ່ຽນລະຫັດຜ່ານຂອງທ່ານ',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 40),
                Form(
                  key: state.changePasswordFormkey,
                  child: SizedBox(
                    width: 400,
                    child: Column(
                      children: [
                        buildPasswordTextField(
                          controller: _oldPassworldController,
                          labelText: 'ລະຫັດຜ່ານເກົ່າ',
                          onChanged: (value) => state.setOldPassword(value),
                          validator: (value) {
                            oldPasswordError =
                                FormValidator.validatePassword(value);
                            return oldPasswordError;
                          },
                          errorText: oldPasswordError,
                          contentPaddingVertical: 4.0,
                          contentPaddingHorizontal: 8.0,
                        ),
                        SizedBox(height: 10),
                        buildPasswordTextField(
                          controller: _newPassworldController,
                          labelText: 'ລະຫັດຜ່ານໃໝ່',
                          onChanged: (value) => state.setNewPassword(value),
                          validator: (value) {
                            newPasswordError =
                                FormValidator.validatePassword(value);
                            return newPasswordError;
                          },
                          errorText: newPasswordError,
                          contentPaddingVertical: 4.0,
                          contentPaddingHorizontal: 8.0,
                        ),
                        SizedBox(height: 10),
                        buildPasswordTextField(
                          controller: _confirmNewPassworldController,
                          labelText: 'ຍືນຍັນລະຫັດຜ່ານໃໝ່',
                          onChanged: (value) =>
                              state.setconfirmNewPassword(value),
                          validator: (value) {
                            confirmNewPasswordError =
                                FormValidator.validateConfirmPassword(
                              state.newPassword,
                              value,
                            );
                            return confirmNewPasswordError;
                          },
                          errorText: confirmNewPasswordError,
                          contentPaddingVertical: 4.0,
                          contentPaddingHorizontal: 8.0,
                        ),
                        SizedBox(height: 50),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size(120, 40),
                                backgroundColor: Color.fromARGB(37, 30, 27, 27),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14.0),
                                  side: BorderSide(
                                      color:
                                          Color.fromARGB(136, 255, 255, 255)),
                                ),
                              ),
                              child: Text('ຍົກເລີກ'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if (state.changePasswordFormkey.currentState!
                                    .validate()) {
                                  onSave(_newPassworldController.text);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size(120, 40),
                                backgroundColor:
                                    Color.fromARGB(255, 18, 25, 228),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14.0),
                                  side: BorderSide(
                                      color:
                                          Color.fromARGB(136, 255, 255, 255)),
                                ),
                              ),
                              child: Text('ຍືນຍັນ'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildPasswordTextField({
    required TextEditingController controller,
    required String labelText,
    required Function(String) onChanged,
    required String? Function(dynamic value) validator,
    double contentPaddingVertical = 8.0,
    double contentPaddingHorizontal = 12.0,
    required String? errorText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: TextStyle(
              fontSize: 13,
              color: Color.fromARGB(131, 255, 255, 255),
            ),
            filled: true,
            fillColor: Color.fromARGB(37, 30, 27, 27),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.0),
              borderSide: BorderSide(color: Color.fromARGB(37, 30, 27, 27)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.0),
              borderSide: BorderSide(color: Colors.blue),
            ),
            errorText: errorText,
          ),
          obscureText: state.isPasswordVisible,
          onChanged: onChanged,
          validator: validator,
        ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              errorText,
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }
}
