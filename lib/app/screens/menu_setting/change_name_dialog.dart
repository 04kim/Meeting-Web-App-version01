import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meeting_app/app/share/states.dart';
import 'package:meeting_app/app/share/widgets.dart';
import 'package:meeting_app/app/core/utils/form_validator.dart';
import 'package:meeting_app/app/screens/menu_setting/firebase_functions.dart';

class ChangeNameDialog {
  final ChangeCompanyNameFormState state;
  final Function(String) onNameChanged;
  final Function(String) onSave;

  ChangeNameDialog(
      {required this.state, required this.onSave, required this.onNameChanged});

  void show(BuildContext context) async {
    final TextEditingController _nameController = TextEditingController();
    // ignore: unused_local_variable
    final result = await showDialog<String>(
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
                  'ຊື່ອົງກອນ',
                  style: TextStyle(fontSize: 22),
                ),
                SizedBox(height: 8),
                Text(
                  'ປ່ຽນຊື່ອົງກອນຂອງທ່ານ',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 50),
                Form(
                  key: state.changeCompanyNameFormKey,
                  child: Column(
                    children: [
                      Container(
                        width: 400,
                        height: 80,
                        child: TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            labelText: 'ປ້ອນຊື່ອົງກອນໃໝ່',
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
                            suffixIcon: buildClearSuffixIcon(
                              _nameController,
                              () => state.setNewCompanyName(''),
                            ),
                          ),
                          onChanged: (value) {
                            state.setNewCompanyName(value);
                          },
                          validator: (value) =>
                              FormValidator.validateName(value!),
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
                              if (state.changeCompanyNameFormKey.currentState!
                                  .validate()) {
                                final newName = _nameController.text;
                                Navigator.pop(context, newName);
                                onSave(newName);
                                onNameChanged(newName);
                                final userEmail =
                                    FirebaseAuth.instance.currentUser!.email;
                                if (userEmail != null) {
                                  await updateCompanyName(userEmail, newName);
                                } else {
                                  print("User email is not available.");
                                }
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
