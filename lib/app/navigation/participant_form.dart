import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class ParticipantForm extends StatefulWidget {
  final void Function(int p1) changeMenuContent;
  const ParticipantForm({Key? key, required this.changeMenuContent})
      : super(key: key);

  @override
  State<ParticipantForm> createState() => _ParticipantFormState();
}

class _ParticipantFormState extends State<ParticipantForm> {
  final _formKey = GlobalKey<FormState>();
  late String _fullName;
  late String _email;
  late String _description;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 1, 0, 33),
      child: AlertDialog(
        title: Text('Add Participant'),
        content: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Full Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter full name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _fullName = value!;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter email';
                    } else if (!EmailValidator.validate(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _email = value!;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Description'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Description';
                    }
                    return null;
                  },
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  onSaved: (value) {
                    _description = value!;
                  },
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        widget.changeMenuContent(4);
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(120, 40),
                        backgroundColor: Color.fromARGB(255, 7, 14, 215),
                      ),
                      child: Text('Cancel'),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _submitForm();
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(120, 40),
                        backgroundColor: Color.fromARGB(255, 7, 14, 215),
                      ),
                      child: Text('Save'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (!EmailValidator.validate(_email)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please enter a valid email address'),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        _saveParticipantData();
      }
    }
  }

  void _saveParticipantData() {
    FirebaseFirestore.instance.collection('participants').add({
      'fullName': _fullName,
      'email': _email,
      'description': _description,
    }).then((_) {
      widget.changeMenuContent(4);
    });
  }
}
