import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meeting_app/app/screens/sign_in/sign_in_form.dart';
import 'package:meeting_app/app/share/logo.dart';
import 'package:meeting_app/app/share/states.dart';
import 'package:meeting_app/app/share/responsive_constainer.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late Future<FirebaseApp> firebase;
  late SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    initializeApp();
  }

  // Initialize Firebase and SharedPreferences

  Future<void> initializeApp() async {
    firebase = Firebase.initializeApp();
    sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Error"),
              ),
              body: Center(
                child: Text("${snapshot.error}"),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              body: ResponsiveLayout(
                builder: (context, isScreenMinimized, containerWidth, logoSize,
                    maxLogoSize) {
                  return SingleChildScrollView(
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          BigLogoWidget(
                              logoSize: logoSize, maxLogoSize: maxLogoSize),
                          Container(
                            color: Color.fromARGB(255, 33, 31, 39),
                            padding: EdgeInsets.all(40),
                            margin: EdgeInsets.only(
                              top: 20,
                              left: 70,
                              right: 70,
                              bottom: 40,
                            ),
                            width: containerWidth,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Sign In Form
                                SignInForm(
                                  state: SignInFormState(sharedPreferences),
                                  sharedPreferences: sharedPreferences,
                                ),
                                SizedBox(height: isScreenMinimized ? 10 : 20),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
