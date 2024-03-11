import 'package:flutter/material.dart';
import 'package:meeting_app/app/core/utils/form_validator.dart';
import 'package:meeting_app/app/share/states.dart';
import 'package:meeting_app/app/screens/forget_password/auth_functions.dart';

//Forget Password Form

class ForgetPasswordForm extends StatefulWidget {
  final ForgetPasswordFormState state;
  ForgetPasswordForm({required this.state});

  @override
  _ForgetPasswordFormState createState() => _ForgetPasswordFormState();
}

class _ForgetPasswordFormState extends State<ForgetPasswordForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.state.forgetPasswordFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ລືມລະຫັດຜ່ານ?',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'ປ້ອນອີເມລທີ່ໃຊ້ສ້າງບັນຊີຂອງທ່ານເພື່ອຣີເຊັດລະຫັດຜ່ານ',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
          ),
          SizedBox(height: 30),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'ອີເມລຂອງທ່ານ',
              labelStyle: TextStyle(fontSize: 15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14.0),
              ),
              prefixIcon: Icon(Icons.email),
            ),
            validator: (value) => FormValidator.validateEmail(value!),
            onChanged: (value) {
              widget.state.forgetPasswordEmail = value;
            },
          ),
          SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              if (widget.state.forgetPasswordFormKey.currentState!.validate()) {
                // Call the AuthFunctions to send the reset code
                AuthFunctions.sendResetCode(context, widget.state);
              }
            },
            child: Text('ສົ່ງລະຫັດຍືນຍັນ'),
            style: ElevatedButton.styleFrom(
              fixedSize: Size(400, 50),
              backgroundColor: Color.fromARGB(255, 18, 25, 228),
            ),
          ),
        ],
      ),
    );
  }
}
