import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class EditMeetingRoomScreen extends StatefulWidget {
  final DocumentSnapshot meetingRoom;

  EditMeetingRoomScreen({required this.meetingRoom});

  @override
  _EditMeetingRoomScreenState createState() => _EditMeetingRoomScreenState();
}

class _EditMeetingRoomScreenState extends State<EditMeetingRoomScreen> {
  final _formKey = GlobalKey<FormState>();
  String _roomName = '';
  String _roomLevel = '';
  String _roomDescription = '';
  String imageUrl = '';

  @override
  void initState() {
    super.initState();
    _roomName = widget.meetingRoom['roomName'];
    _roomLevel = widget.meetingRoom['roomLevel'];
    _roomDescription = widget.meetingRoom['roomDescription'];
    imageUrl = widget.meetingRoom['imageUrl'];
  }

  Widget _buildImage() {
    return GestureDetector(
      onTap: () => _pickImage(),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[200],
        ),
        width: double.infinity,
        height: 150,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: imageUrl.isNotEmpty
              ? Image.network(
                  imageUrl,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                )
              : Icon(Icons.add_a_photo, size: 50, color: Colors.grey),
        ),
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

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      await FirebaseFirestore.instance
          .collection('meetingRooms')
          .doc(widget.meetingRoom.id)
          .update({
        'roomName': _roomName,
        'roomLevel': _roomLevel,
        'roomDescription': _roomDescription,
        'imageUrl': imageUrl,
      });

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Meeting Room'),
      ),
      body: Center(
        child: SizedBox(
          width: 400,
          height: 500,
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
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
                    SizedBox(height: 20),
                    _buildImage(),
                    SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: _submitForm,
                        child: Text('Save Changes'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, Function(String?) onSave) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
      child: TextFormField(
        initialValue: label == 'Room Name'
            ? widget.meetingRoom['roomName']
            : label == 'Room Level'
                ? widget.meetingRoom['roomLevel']
                : widget.meetingRoom['roomDescription'],
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
