import 'package:flutter/material.dart';
import 'package:meeting_app/app/screens/change_password/change_password_form.dart';
import 'package:meeting_app/app/share/responsive_constainer.dart';
import 'package:meeting_app/app/share/widgets.dart';
import 'package:meeting_app/app/share/logo.dart';
import 'package:meeting_app/app/share/states.dart';

class ChangePasswordPage extends StatefulWidget {
  final String email;

  const ChangePasswordPage({Key? key, required this.email}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(leading: backButton()), // Displaying app bar with back button
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
                        //Change password Form
                        ChangePasswordForm(
                          state: ChangePasswordFormState(),
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
