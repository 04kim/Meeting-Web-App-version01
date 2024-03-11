import 'package:flutter/material.dart';
import 'package:meeting_app/app/core/utils/form_validator.dart';
import 'package:meeting_app/app/screens/sign_up/sign_up.dart';
import 'package:meeting_app/app/screens/forget_password/forget_password.dart';
import 'package:meeting_app/app/share/states.dart';
import 'package:meeting_app/app/share/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meeting_app/app/screens/sign_in/sign_in_button_function.dart';
import 'package:meeting_app/app/screens/sign_in/auth_functions.dart';

// Sign In Form

class SignInForm extends StatefulWidget {
  final SignInFormState state;
  final SharedPreferences sharedPreferences;

  SignInForm({required this.state, required this.sharedPreferences});
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  late bool rememberMe = widget.state.getRememberMe;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    _loadUserEmailPassword();
    super.initState();
  }

// Load user email and "Remember Me" status from SharedPreferences

  void _loadUserEmailPassword() {
    LoadUserDataResult result = AuthFunctions.loadUserEmailPassword(
        widget.state, widget.sharedPreferences);

// Set the loaded email and "Remember Me" status to the form's state
    setState(() {
      _emailController.text = result.email;
      widget.state.rememberMe = result.rememberMe;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.state.getSignInFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ເຂົ້າສູ່ລະບົບ',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'ເຂົ້າສູ່ລະບົບເພື່ອຈັດການບັນຊີ',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(height: 30),
          TextFormField(
            controller: _emailController,
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
              widget.state.setSignInEmail(value);
            },
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(
              labelText: 'ລະຫັດຜ່ານ',
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
              widget.state.setSignInPassword(value);
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Checkbox(
                value: widget.state.rememberMe,
                onChanged: (value) {
                  setState(() {
                    widget.state.toggleRememberMe(value!);
                    if (!value) {
                      _emailController.clear();
                      _passwordController.clear();
                    }
                  });
                },
              ),
              Text('ຈື່ຂ້ອຍ'),
              SizedBox(width: 10),
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (builder) {
                    return ForgetPasswordPage();
                  }));
                },
                child: Text('ລືມລະຫັດຜ່ານ'),
              ),
            ],
          ),
          SizedBox(height: 30),
          ElevatedButton(
            onPressed: () async {
              await SignInFunctions.signInUser(
                context,
                widget.state,
                _emailController,
                _passwordController,
                widget.sharedPreferences,
              );
            },
            child: Text('ເຂົ້າສູ່ລະບົບ'),
            style: ElevatedButton.styleFrom(
              fixedSize: Size(400, 50),
              backgroundColor: Color.fromARGB(255, 18, 25, 228),
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("ທ່ານຍັງບໍ່ມີບັນຊີ?"),
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (builder) {
                    return SignUpPage();
                  }));
                },
                child: Text('ສ້າງບັນຊີ'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
