import 'package:flutter/material.dart';
import 'package:meeting_app/app/screens/forget_password/forget_password_form.dart';
import 'package:meeting_app/app/share/responsive_constainer.dart';
import 'package:meeting_app/app/share/states.dart';
import 'package:meeting_app/app/share/widgets.dart';
import 'package:meeting_app/app/share/logo.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: backButton()),
      body: ResponsiveLayout(
        builder: (context, isScreenMinimized, containerWidth, logoSize,
            maxLogoSize) {
          return SingleChildScrollView(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BigLogoWidget(logoSize: logoSize, maxLogoSize: maxLogoSize),
                  Container(
                    color: Color.fromARGB(255, 33, 31, 39),
                    padding: EdgeInsets.all(40),
                    margin: EdgeInsets.only(
                      top: 0,
                      left: 70,
                      right: 70,
                      bottom: 40,
                    ),
                    width: containerWidth,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Forget Password Form
                        ForgetPasswordForm(
                          state: ForgetPasswordFormState(),
                        ),
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
}
