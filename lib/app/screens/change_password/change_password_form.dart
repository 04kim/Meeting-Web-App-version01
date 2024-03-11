import 'package:flutter/material.dart';
import 'package:meeting_app/app/core/utils/form_validator.dart';
import 'package:meeting_app/app/share/states.dart';
import 'package:meeting_app/app/share/widgets.dart';

//Change password Form

class ChangePasswordForm extends StatefulWidget {
  final ChangePasswordFormState state;
  ChangePasswordForm({required this.state});

  @override
  _ChangePasswordFormState createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  String get email => widget.state.userEmail;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.state.changePasswordFormkey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ລະຫັດຍືນຍັນຂອງທ່ານ',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'ລະຫັດຍືນຍັນ',
              labelStyle: TextStyle(fontSize: 15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14.0),
              ),
              prefixIcon: Icon(Icons.lock),
              suffixIcon: buildVisibilitySuffixIcon(
                widget.state.isPasswordVisible,
                () {
                  setState(() {
                    widget.state.togglePasswordVisibility();
                  });
                },
              ),
            ),
            obscureText: !widget.state.isPasswordVisible,
            validator: (value) => FormValidator.validateConfirmCode(value!),
            onChanged: (value) {
              widget.state.setconfirmNewPassword(value);
            },
          ),
          SizedBox(height: 20),
          Text(
            'ລະຫັດຜ່ານໃໝ່',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'ລະຫັດຜ່ານໃໝ່',
              labelStyle: TextStyle(fontSize: 15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14.0),
              ),
              prefixIcon: Icon(Icons.lock),
              suffixIcon: buildVisibilitySuffixIcon(
                widget.state.isPasswordVisible,
                () {
                  setState(() {
                    widget.state.togglePasswordVisibility();
                  });
                },
              ),
            ),
            obscureText: !widget.state.isPasswordVisible,
            validator: (value) => FormValidator.validatePassword(value!),
            onChanged: (value) {
              widget.state.setNewPassword(value);
            },
          ),
          SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'ຢືນຍັນ ລະຫັດຜ່ານໃໝ່',
              labelStyle: TextStyle(fontSize: 15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14.0),
              ),
              prefixIcon: Icon(Icons.lock),
              suffixIcon: buildVisibilitySuffixIcon(
                widget.state.isPasswordVisible,
                () {
                  setState(() {
                    widget.state.togglePasswordVisibility();
                  });
                },
              ),
            ),
            obscureText: !widget.state.isPasswordVisible,
            validator: (value) => FormValidator.validateConfirmPassword(
                widget.state.newPassword, value!),
            onChanged: (value) {
              widget.state.setconfirmNewPassword(value);
            },
          ),
          SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              if (widget.state.changePasswordFormkey.currentState!
                  .validate()) {}
            },
            child: Text('Submit'),
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
