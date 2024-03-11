import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meeting_app/app/share/dialogs.dart';
import 'package:meeting_app/app/share/states.dart';

//sign up function for calling to use in sign up button
class SignUpFunctions {
  static Future<void> signUpUser(BuildContext context, SignUpFormState state,
      TextEditingController nameController) async {
    if (state.signUpFormKey.currentState!.validate()) {
      state.signUpFormKey.currentState?.save();

      try {
        // Create a user using Firebase Authentication
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: state.signUpEmail,
          password: state.signUpPassword,
        );

        String? email = FirebaseAuth.instance.currentUser!.email;

        // Add user data to Firestore
        await FirebaseFirestore.instance.collection('users').doc(email).set({
          'email': email,
          'companyName': state.signUpCompanyName,
        });

        state.signUpFormKey.currentState?.reset();
        nameController.clear();
        showSignUpSuccessDialog(context);
      } on FirebaseAuthException catch (e) {
        print(e.code);
        String message;
        if (e.code == 'email-already-in-use') {
          message = "ມີອີເມລນີ້ໃນລະບົບແລ້ວ ກະລຸນາໃຊ້ອີເມລອື່ນ!";
        } else {
          message = e.code;
        }
        showErrorSnackBar1(context, message,
            backgroundColor: const Color.fromARGB(255, 173, 12, 0));
      } on FirebaseException catch (e) {
        print(e.message);
      }
    }
  }
}
