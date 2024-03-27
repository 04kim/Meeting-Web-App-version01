import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  String? _imageAsset;

  Future<void> _handleFormSubmit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        // Save the meeting room details to Firestore
        await _firestore.collection('meetingRooms').add({
          'roomName': _roomName,
          'roomLevel': _roomLevel,
          'roomDescription': _roomDescription,
          'imageAsset': _imageAsset,
        });

        // Refresh the meeting room page
        widget.changeMenuContent(2);
      } catch (error) {
        print('Error saving to Firestore: $error');
      }
    }
  }

  Widget _buildImage() {
    return GestureDetector(
      onTap: () => _pickImage(),
      child: Container(
        child: _imageAsset != null
            ? Image.asset(
                _imageAsset!,
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

class ImagePickerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // In this example, you can directly return your list of assets here,
    // or you can dynamically generate a list of assets based on some logic.
    // For simplicity, let's assume you have a fixed list of assets.
    List<String> imageAssets = [
      'assets/image/A01.jpg',
      'assets/image/A02.jpg',
      'assets/image/A03.jpg',
      'assets/image/A04.jpg',
      'assets/image/A05.jpg',
      'assets/image/A06.jpg',
      // Add more asset paths here
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Pick an Image'),
      ),
      body: SingleChildScrollView(
        controller: ScrollController(),
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for (int index = 0; index < imageAssets.length; index++)
              Padding(
                padding: EdgeInsets.all(5.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context, imageAssets[index]);
                  },
                  child: Container(
                    width: 300, // Adjust width as needed
                    height: 300, // Adjust height as needed
                    child: Image.asset(
                      imageAssets[index],
                      fit: BoxFit
                          .cover, // Adjust fit to cover or contain as needed
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
