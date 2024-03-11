import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meeting_app/app/screens/sign_in/sign_in.dart';
import 'package:meeting_app/app/share/logo.dart';
import 'package:meeting_app/app/share/dialogs.dart';
import 'package:meeting_app/app/screens/menu_setting/firebase_functions.dart';
import 'package:meeting_app/app/screens/menu_setting/change_name_dialog.dart';
import 'package:meeting_app/app/screens/menu_setting/set_monitor_code_dialog.dart';
import 'package:meeting_app/app/screens/menu_setting/log_out_dialog.dart';
import 'package:meeting_app/app/screens/menu_setting/change_password_dialog.dart';
import 'package:meeting_app/app/navigation/menu_setting_content.dart';
import 'package:meeting_app/app/share/states.dart';
import 'package:meeting_app/app/core/utils/form_validator.dart';
import 'package:another_flushbar/flushbar.dart';

class MenuSettingPage extends StatefulWidget {
  final String companyName;

  const MenuSettingPage({Key? key, required this.companyName})
      : super(key: key);

  @override
  State<MenuSettingPage> createState() => _MenuSettingPageState();
}

class _MenuSettingPageState extends State<MenuSettingPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Color appBarColor = Color.fromARGB(15, 10, 52, 56);
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  late Stream<String> _companyNameStream;
  int selectedMenu = 0;
  String? codeError;
  String? _errorMessage;

  String? oldPasswordError;
  String? newPasswordError;
  String? confirmNewPasswordError;

  @override
  void initState() {
    super.initState();
    selectedMenu = 0;
    final userEmail = FirebaseAuth.instance.currentUser!.email;

    _companyNameStream = streamCompanyName(userEmail!);
  }

  void _handleFirstButtonPressed() {
    setState(() {
      selectedMenu = 1;
      print(selectedMenu);
    });
  }

  void _handleSecondButtonPressed() {
    setState(() {
      selectedMenu = 2;
      print(selectedMenu);
    });
  }

  void changeMenuContent(int selectedMenu) {
    setState(() {
      this.selectedMenu = selectedMenu;
    });
  }

  void handleLogOut() async {
    try {
      await _firebaseAuth.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignInPage()),
      );
    } catch (e) {
      print("Error during sign-out: $e");
    }
  }

  void handleNameChange(String newName) async {
    final validationMessage = FormValidator.validateName(newName);
    if (validationMessage == null) {
      final userEmail = FirebaseAuth.instance.currentUser!.email;
      await updateCompanyName(userEmail!, newName);
      setState(() {});

      Navigator.pop(context);
      showChangedNameSuccessDialog(context, newName);
    } else {
      print(validationMessage);
    }
  }

  void handleCodeChange(String MonitorCode) async {
    final validationMessage = FormValidator.validatePassword(MonitorCode);
    if (validationMessage == null) {
      final userEmail = FirebaseAuth.instance.currentUser!.email;
      await saveMonitorCode(userEmail!, MonitorCode);
      Navigator.pop(context);
      showChangedCodeSuccessDialog(context);
    } else {
      print('mornitorCode validation meaasage: $validationMessage');
    }
  }

  void updateCodeErrorMessage(String? errorMessage) {
    setState(() {
      codeError = errorMessage;
    });
  }

  void handleChangePassword(
      String oldPassword, String newPassword, String confirmNewPassword) async {
    final validationOldPassword = FormValidator.validatePassword(oldPassword);
    final validationNewPassword = FormValidator.validatePassword(newPassword);
    final validationConfirmPassword =
        FormValidator.validateConfirmPassword(newPassword, confirmNewPassword);

    if (validationOldPassword == null &&
        validationNewPassword == null &&
        validationConfirmPassword == null) {
      try {
        final user = _firebaseAuth.currentUser;
        final credential = EmailAuthProvider.credential(
          email: user!.email!,
          password: oldPassword,
        );

        await user.reauthenticateWithCredential(credential);
        await user.updatePassword(newPassword);

        Navigator.pop(context);
        showChangedPasswordSuccessDialog(context);
      } on FirebaseAuthException catch (e) {
        print(e.code);
        String message;
        if (e.code == 'wrong-password') {
          message = "ລະຫັດຜ່ານເກົ່າບໍ່ຖືກຕ້ອງ! ";
        } else {
          message = e.code;
        }
        Flushbar(
          message: message,
          duration: Duration(seconds: 4),
          backgroundColor: Colors.red,
          icon: Icon(
            Icons.error,
            color: Colors.white,
          ),
        )..show(context);
      }
    } else {
      print('Validation errors:');
      print('Old Password: $validationOldPassword');
      print('New Password: $validationNewPassword');
      print('Confirm Password: $validationConfirmPassword');
    }
  }

  void showChangePasswordDialog(BuildContext context) {
    final ChangePasswordFormState changePasswordFormState =
        ChangePasswordFormState();

    ChangePasswordDialog(
      state: changePasswordFormState,
      onSave: (newPassword) {
        handleChangePassword(
          changePasswordFormState.oldPassword,
          newPassword,
          changePasswordFormState.confirmNewPassword,
        );
      },
      oldPasswordError: oldPasswordError,
      newPasswordError: newPasswordError,
      confirmNewPasswordError: confirmNewPasswordError,
      errorMessage: _errorMessage,
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: Center(
          child: LeftLogoWidget(),
        ),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        actions: [
          StreamBuilder<String>(
            stream: _companyNameStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                final companyNameFromStream =
                    snapshot.data ?? widget.companyName;

                return PopupMenuButton<int>(
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 1,
                      child: Row(
                        children: [
                          Icon(Icons.account_circle),
                          SizedBox(width: 10),
                          Text(companyNameFromStream),
                        ],
                      ),
                    ),
                    PopupMenuDivider(),
                    PopupMenuItem(
                      value: 2,
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {});
                            },
                            child: Row(
                              children: [
                                Icon(Icons.settings),
                                SizedBox(width: 10),
                                Text('ການຕັ້ງຄ່າ'),
                                SizedBox(width: 10),
                              ],
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextButton(
                                  onPressed: () async {
                                    ChangeNameDialog(
                                      state: ChangeCompanyNameFormState(),
                                      onSave: handleNameChange,
                                      onNameChanged: (newName) {
                                        setState(() {});
                                      },
                                    ).show(context);
                                  },
                                  child: Text('ປ່ຽນຊື່ອົງກອນ'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    showChangePasswordDialog(context);
                                  },
                                  child: Text('ຕັ້ງຄ່າລະຫັດຜ່ານ'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    SetMonitorCodeDialog(
                                      state: SetMonitorCodeFormState(),
                                      onSave: handleCodeChange,
                                      updateCodeError: updateCodeErrorMessage,
                                      codeError: codeError,
                                    ).show(context);
                                  },
                                  child: Text('ຕັ້ງຄ່າລະຫັດຜ່ານໜ້າຈໍ'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 3,
                      child: Row(
                        children: [
                          Icon(Icons.logout),
                          SizedBox(width: 10),
                          Text('ອອກຈາກລະບົບ'),
                        ],
                      ),
                    ),
                  ],
                  icon: Row(
                    children: [
                      Icon(Icons.account_circle),
                      SizedBox(width: 10),
                      Text(companyNameFromStream),
                    ],
                  ),
                  onSelected: (value) {
                    if (value == 1) {
                    } else if (value == 3) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return LogOutDialog(onLogOut: handleLogOut);
                        },
                      );
                    }
                  },
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: appBarColor,
          child: Column(
            children: [
              SmallLogoWidget(),
              Divider(
                thickness: 1,
                color: Colors.white,
              ),
              ListTile(
                title: TextButton(
                  onPressed: _handleFirstButtonPressed,
                  child: Text(
                    'ຈັດການການປະຊຸມ',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 10),
              ListTile(
                title: TextButton(
                  onPressed: _handleSecondButtonPressed,
                  child: Text('ຈັດການຫ້ອງປະຊຸມ',
                      style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Builder(
        builder: (context) => MenuSettingContent(
            selectedMenu, changeMenuContent), // Pass selectedMenu
      ),
    );
  }
}
