import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditParticipantForm extends StatefulWidget {
  final void Function(int) changeMenuContent;

  final String participantId;
  final String fullName;
  final String email;
  final String description;

  const EditParticipantForm(
      {Key? key,
      required this.participantId,
      required this.fullName,
      required this.email,
      required this.description,
      required this.changeMenuContent})
      : super(key: key);

  @override
  _EditParticipantFormState createState() => _EditParticipantFormState();
}

class _EditParticipantFormState extends State<EditParticipantForm> {
  final _formKey = GlobalKey<FormState>();
  late String _fullName;
  late String _email;
  late String _description;

  @override
  void initState() {
    super.initState();
    _fullName = widget.fullName;
    _email = widget.email;
    _description = widget.description;
  }

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
                  initialValue: _fullName,
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
                  initialValue: _email,
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
                  initialValue: _description,
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
                        Navigator.pop(context);
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
      _saveParticipantData();
    }
  }

  void _saveParticipantData() {
    FirebaseFirestore.instance
        .collection('participants')
        .doc(widget.participantId)
        .update({
      'fullName': _fullName,
      'email': _email,
      'description': _description,
    }).then((_) {
      // Navigate back to the ManageParticipants page
      Navigator.pop(context);
      // Trigger a menu content change, assuming '4' is the ID for ManageParticipants
      widget.changeMenuContent(4);
    });
  }
}
