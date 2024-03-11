import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpFormState {
  final signUpFormKey = GlobalKey<FormState>();
  late String signUpCompanyName;
  late String signUpEmail;
  late String signUpPassword;
  late String signUpConfirmPassword;
  bool isPasswordVisible = false;

  void setCompanyName(String value) {
    signUpCompanyName = value;
  }

  void setSignUpEmail(String value) {
    signUpEmail = value;
  }

  void setSignUpPassword(String value) {
    signUpPassword = value;
  }

  void setsignUpConfirmPassword(String value) {
    signUpConfirmPassword = value;
  }

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
  }
}

class SignInFormState {
  final signInFormKey = GlobalKey<FormState>();
  late String signInEmail;
  late String signInPassword;
  bool rememberMe = false;
  bool isPasswordVisible = false;
  late SharedPreferences sharedPreferences;

  SignInFormState(this.sharedPreferences);

  void setSignInEmail(String value) {
    signInEmail = value;
  }

  void setSignInPassword(String value) {
    signInPassword = value;
  }

  void toggleRememberMe(bool value) {
    if (value) {
      // Save the email and password in sharedPreferences if "Remember Me" is checked
      sharedPreferences.setString('email', signInEmail);
      sharedPreferences.setString('password', signInPassword);
    } else {
      // Clear the email and password from sharedPreferences if "Remember Me" is unchecked
      sharedPreferences.remove('email');
      sharedPreferences.remove('password');
    }
    rememberMe = value;
    sharedPreferences.setBool('remember_me', value);
  }

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
  }

  bool get getRememberMe => rememberMe;
  GlobalKey<FormState> get getSignInFormKey => signInFormKey;
}

class ForgetPasswordFormState {
  final forgetPasswordFormKey = GlobalKey<FormState>();
  late String forgetPasswordEmail;

  void setForgetPassword(String value) {
    forgetPasswordEmail = value;
  }
}

class ChangePasswordFormState {
  final changePasswordFormkey = GlobalKey<FormState>();
  late String userEmail;
  late String oldPassword;
  late String newPassword;
  late String confirmNewPassword;

  bool isPasswordVisible = false;

  void setUserEamil(String value) {
    userEmail = value;
  }

  void setOldPassword(String value) {
    oldPassword = value;
  }

  void setNewPassword(String value) {
    newPassword = value;
  }

  void setconfirmNewPassword(String value) {
    confirmNewPassword = value;
  }

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
  }
}

class ChangeCompanyNameFormState {
  final changeCompanyNameFormKey = GlobalKey<FormState>();
  late String changeCompanyName;
  void setNewCompanyName(String value) {
    changeCompanyName = value;
  }
}

class SetMonitorCodeFormState {
  final setMonitorCodeFormKey = GlobalKey<FormState>();
  late String setMonitorCode;
  void setNewMonitorCode(String value) {
    setMonitorCode = value;
  }
}
