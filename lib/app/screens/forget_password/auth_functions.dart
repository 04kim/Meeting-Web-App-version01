import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meeting_app/app/share/dialogs.dart';
import 'package:meeting_app/app/share/states.dart';

// A utility class that provides functions related to authentication operations.
class AuthFunctions {
  static void sendResetCode(
      BuildContext context, ForgetPasswordFormState state) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      await _auth.sendPasswordResetEmail(email: state.forgetPasswordEmail);
      state.forgetPasswordFormKey.currentState?.reset();
      showSentPasswordSuccessDialog(context);
    } catch (e) {
      print(e);
    }
  }
}
