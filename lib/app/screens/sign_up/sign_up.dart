import 'package:flutter/material.dart';
import 'package:meeting_app/app/screens/sign_up/sign_up_form.dart';
import 'package:meeting_app/app/share/states.dart';
import 'package:meeting_app/app/share/logo.dart';
import 'package:meeting_app/app/share/responsive_constainer.dart';
import 'package:firebase_core/firebase_core.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPage();
}

class _SignUpPage extends State<SignUpPage> {
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
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
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Left Logo (Only shown on larger screens)
                      if (!isScreenMinimized)
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.only(left: 140),
                            child: LeftLogoWidget(),
                          ),
                        ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Small Logo (Shown on smaller screens)
                              if (isScreenMinimized) SmallLogoWidget(),
                              Expanded(
                                // Main content area
                                child: Container(
                                  color: Color.fromARGB(255, 33, 31, 39),
                                  padding: EdgeInsets.all(40),
                                  margin: EdgeInsets.all(30),
                                  width: containerWidth,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Sign Up Form
                                        SignUpForm(state: SignUpFormState()),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
