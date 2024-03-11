import 'package:flutter/material.dart';
import 'package:meeting_app/app/share/states.dart';
import 'package:meeting_app/app/core/utils/form_validator.dart';

class SetMonitorCodeDialog {
  final SetMonitorCodeFormState state;
  final Function(String) onSave;
  final Function(String?) updateCodeError;
  final String? codeError;

  SetMonitorCodeDialog({
    required this.state,
    required this.onSave,
    required this.updateCodeError,
    required this.codeError,
  });

  void show(BuildContext context) {
    final TextEditingController _codeController = TextEditingController();
    String? codeError;

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.4,
            height: MediaQuery.of(context).size.height * 0.6,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
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
                SizedBox(height: 20.0),
                Text(
                  'ກຳນົດລະຫັດຜ່ານໜ້າຈໍ',
                  style: TextStyle(fontSize: 22),
                ),
                SizedBox(height: 8),
                Text(
                  'ລະຫັດຜ່ານໜ້າຈໍຕ້ອງມີ6 ຕົວເລກ',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 50),
                Form(
                  key: state.setMonitorCodeFormKey,
                  child: Column(
                    children: [
                      Container(
                        width: 400,
                        height: 80,
                        child: FormField(
                          builder: (FormFieldState<String> field) {
                            return TextFormField(
                              controller: _codeController,
                              decoration: InputDecoration(
                                labelText: 'ປ້ອນລະຫັດຜ່ານໜ້າຈໍໃໝ່',
                                labelStyle: TextStyle(
                                    fontSize: 13,
                                    color: Color.fromARGB(131, 255, 255, 255)),
                                filled: true,
                                fillColor: Color.fromARGB(37, 30, 27, 27),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14.0),
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(37, 30, 27, 27)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14.0),
                                  borderSide: BorderSide(color: Colors.blue),
                                ),
                                errorText: codeError,
                              ),
                              onChanged: (value) {
                                state.setNewMonitorCode(value);
                                updateCodeError(null);
                              },
                              validator: (value) {
                                final validationMessage =
                                    FormValidator.validatePassword(value!);
                                updateCodeError(validationMessage);
                                return validationMessage;
                              },
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 60),
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
                                    color: Color.fromARGB(136, 255, 255, 255)),
                              ),
                            ),
                            child: Text('ຍົກເລີກ'),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              if (state.setMonitorCodeFormKey.currentState!
                                  .validate()) {
                                final monitorCode = _codeController.text;
                                onSave(monitorCode);
                                Navigator.pop(context);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(120, 40),
                              backgroundColor: Color.fromARGB(255, 18, 25, 228),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14.0),
                                side: BorderSide(
                                    color: Color.fromARGB(136, 255, 255, 255)),
                              ),
                            ),
                            child: Text('ຍືນຍັນ'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
