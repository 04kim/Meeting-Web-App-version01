import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class MeetingRoomForm extends StatefulWidget {
  final void Function(int p1) changeMenuContent;

  const MeetingRoomForm({Key? key, required this.changeMenuContent})
      : super(key: key);
  // Add this method
  Future<void> submitForm() async {
    await _MeetingRoomFormState()._handleFormSubmit();
  }

  @override
  State<MeetingRoomForm> createState() => _MeetingRoomFormState();
}

final _firestore = FirebaseFirestore.instance;

class _MeetingRoomFormState extends State<MeetingRoomForm> {
  final _formKey = GlobalKey<FormState>();
  String _roomName = '';
  String _roomLevel = '';
  String _roomDescription = '';
  String imageUrl = '';

  Future<void> _handleFormSubmit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      await FirebaseFirestore.instance.collection('meetingRooms').add({
        'roomName': _roomName,
        'roomLevel': _roomLevel,
        'roomDescription': _roomDescription,
        'imageUrl': imageUrl,
      });

      widget.changeMenuContent(2); // Refresh the meeting room page
    }
  }

  Widget _buildImage() {
    return GestureDetector(
      onTap: () => _pickImage(),
      child: Container(
        child: imageUrl.isNotEmpty
            ? Image.network(
                imageUrl,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
                alignment: Alignment(0, 0),
              )
            : Icon(Icons.add_a_photo, size: 50, color: Colors.grey),
      ),
    );
  }

  void _pickImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);

    if (file == null) return;

    setState(() {
      imageUrl = file.path;
    });

    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('images');
    Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);

    try {
      await referenceImageToUpload.putFile(File(file.path));
      imageUrl = await referenceImageToUpload.getDownloadURL();
    } catch (error) {
      print('Error uploading image: $error');
      // Handle the error as needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: AlignmentDirectional(0, 0),
          child: Container(
            width: 450,
            height: 450,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 15, 3, 57),
              borderRadius: BorderRadius.circular(15),
            ),
            alignment: AlignmentDirectional(0, 0),
            child: Align(
              alignment: AlignmentDirectional(0, 0),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTextField('Room Name', (value) {
                        _roomName = value!;
                      }),
                      _buildTextField('Room Level', (value) {
                        _roomLevel = value!;
                      }),
                      _buildTextField('Room Description', (value) {
                        _roomDescription = value!;
                      }),
                      _buildImage(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Material(
              color: Colors.blue, // Default color
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                onTap: _handleFormSubmit,
                child: Container(
                  height: 40,
                  width: 120,
                  child: Center(
                    child: Text(
                      'Add',
                      style: TextStyle(
                        color: Colors.white, // Adjust text color
                        fontSize: 14, // Adjust text size
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildTextField(String label, Function(String?) onSave) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 4),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
        onSaved: onSave,
      ),
    );
  }
}
