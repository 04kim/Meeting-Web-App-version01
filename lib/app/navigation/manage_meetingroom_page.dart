import 'package:flutter/material.dart';
import 'package:meeting_app/app/share/room_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meeting_app/app/navigation/meeting_room_form.dart';

class ManageMeetingroomPage extends StatelessWidget {
  final void Function(int) changeMenuContent;
  ManageMeetingroomPage({Key? key, required this.changeMenuContent})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final MeetingRoomForm meetingRoomForm = MeetingRoomForm(
      changeMenuContent: changeMenuContent,
    );
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 6, 3, 42),
      body: Center(
        child: ManageMeetingroomPageBody(
          changeMenuContent: changeMenuContent,
          meetingRooms: [],
          meetingRoomForm: meetingRoomForm,
        ),
      ),
    );
  }
}

class ManageMeetingroomPageBody extends StatefulWidget {
  final void Function(int) changeMenuContent;
  List<DocumentSnapshot> meetingRooms;
  final MeetingRoomForm meetingRoomForm;
  ManageMeetingroomPageBody({
    Key? key,
    required this.changeMenuContent,
    required this.meetingRooms,
    required this.meetingRoomForm,
  }) : super(key: key);

  @override
  _ManageMeetingroomPageBodyState createState() =>
      _ManageMeetingroomPageBodyState();
}

class _ManageMeetingroomPageBodyState extends State<ManageMeetingroomPageBody> {
  int selectedMenu = 0;
  List<DocumentSnapshot> meetingRooms = [];
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    selectedMenu = 0;
    _fetchMeetingRooms();
    _scrollController = ScrollController();
  }

  Future<void> _fetchMeetingRooms() async {
    final QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('meetingRooms').get();

    setState(() {
      widget.meetingRooms = querySnapshot.docs;
    });
  }

  Future<void> _addMeetingRoom() async {
    // Call _handleFormSubmit from the MeetingRoomForm instance
    await widget.meetingRoomForm.submitForm();
    // After adding, make sure to call _fetchMeetingRooms() to update the list
    await _fetchMeetingRooms(); // Update the list after adding a new meeting room
    setState(() {
      selectedMenu = widget.meetingRooms.length - 1;
    });
  }

  void _handleFifthButtonPressed() {
    setState(() {
      widget.changeMenuContent(5);
      print(selectedMenu);
      _addMeetingRoom();
    });
  }

  

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (widget.meetingRooms.isNotEmpty)
          Scrollbar(
            controller: _scrollController,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: _scrollController,
              physics: AlwaysScrollableScrollPhysics(),
              child: Row(
                children: [
                  for (int i = 0; i < widget.meetingRooms.length; i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: RoomCard(
                        meetingRoom: widget.meetingRooms[i],
                        imageUrl: widget.meetingRooms[i]['imageUrl'],
                        refreshMeetingRooms: _fetchMeetingRooms,
                      ),
                    ),
                ],
              ),
            ),
          ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Material(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () {
                      _handleFifthButtonPressed();
                    },
                    child: Container(
                      height: 40,
                      width: 120,
                      child: Center(
                        child: Text(
                          'Add Room',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
