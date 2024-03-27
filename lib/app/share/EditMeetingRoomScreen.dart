import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meeting_app/app/navigation/meeting_room_form.dart';

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
  String _imageAsset = '';

  @override
  void initState() {
    super.initState();
    _roomName = widget.meetingRoom['roomName'];
    _roomLevel = widget.meetingRoom['roomLevel'];
    _roomDescription = widget.meetingRoom['roomDescription'];
    _imageAsset = widget.meetingRoom['imageAsset'];
  }

  Widget _buildImage() {
    return GestureDetector(
      onTap: () => _pickImage(),
      child: Container(
        // ignore: unnecessary_null_comparison
        child: _imageAsset != null
            ? Image.asset(
                _imageAsset,
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
    // Open the image picker and set the selected image asset path
    final pickedImage = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (context) => ImagePickerScreen()),
    );

    if (pickedImage != null) {
      setState(() {
        _imageAsset = pickedImage;
      });
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        await FirebaseFirestore.instance
            .collection('meetingRooms')
            .doc(widget.meetingRoom.id)
            .update({
          'roomName': _roomName,
          'roomLevel': _roomLevel,
          'roomDescription': _roomDescription,
          'imageAsset': _imageAsset,
        });
        Navigator.pop(context);
      } catch (e) {
        print(e);
      }
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
          height: 560,
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
                    SizedBox(height: 30),
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
