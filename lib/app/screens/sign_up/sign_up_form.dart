import 'package:flutter/material.dart';
import 'package:meeting_app/app/core/utils/form_validator.dart';
import 'package:meeting_app/app/share/widgets.dart';
import 'package:meeting_app/app/share/states.dart';
import 'package:meeting_app/app/screens/sign_in/sign_in.dart';
import 'package:meeting_app/app/screens/sign_up/sign_up_button_function.dart';

// Sign Up Form

class SignUpForm extends StatefulWidget {
  final SignUpFormState state;

  SignUpForm({required this.state});

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.state.signUpFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ສ້າງບັນຊີໃໝ່',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          Text(
            'ສ້າງບັນຊີດ້ວຍອີເມລ',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 50),
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'ຊື່ອົງກອນຂອງທ່ານ',
              labelStyle: TextStyle(fontSize: 15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14.0),
              ),
              prefixIcon: Icon(Icons.person),
              suffixIcon: buildClearSuffixIcon(
                _nameController,
                () => widget.state.setCompanyName(''),
              ),
            ),
            validator: (value) => FormValidator.validateName(value!),
            onChanged: (value) {
              widget.state.setCompanyName(value);
            },
          ),
          SizedBox(height: 10),
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
              widget.state.setSignUpEmail(value);
            },
          ),
          SizedBox(height: 10),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'ລະຫັດຜ່ານ',
              labelStyle: TextStyle(fontSize: 15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14.0),
              ),
              prefixIcon: Icon(Icons.key),
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
              widget.state.setSignUpPassword(value);
            },
          ),
          SizedBox(height: 10),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'ຍືນຍັນລະຫັດຜ່ານ',
              labelStyle: TextStyle(fontSize: 15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14.0),
              ),
              prefixIcon: Icon(Icons.key),
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
                widget.state.signUpPassword, value!),
            onChanged: (value) {
              widget.state.setsignUpConfirmPassword(value);
            },
          ),
          SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {
              SignUpFunctions.signUpUser(
                  context, widget.state, _nameController);
            },
            child: Text('ສ້າງບັນຊີໃໝ່'),
            style: ElevatedButton.styleFrom(
              fixedSize: Size(400, 50),
              backgroundColor: Color.fromARGB(255, 18, 25, 228),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'ທ່ານມີອີເມລແລ້ວ?',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (builder) {
                    return SignInPage();
                  }));
                },
                child: Text(
                  'ເຂົ້າສູ່ລະບົບ',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
