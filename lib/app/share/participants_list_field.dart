import 'package:flutter/material.dart';

class MeetingParticipant {
  String fullName = '';
  String role = '';
}

class MeetingParticipantWidget extends StatelessWidget {
  final MeetingParticipant participant;
  final VoidCallback onDelete;

  MeetingParticipantWidget({
    required this.participant,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(color: Colors.white),
              child: TextField(
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: 'ຊື່ ແລະ ນາມສະກຸນ',
                  hintStyle: TextStyle(color: Color.fromARGB(109, 27, 26, 26)),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  participant.fullName = value;
                },
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Container(
              decoration: BoxDecoration(color: Colors.white),
              child: TextFormField(
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: 'ໜ້າທີ່',
                  hintStyle: TextStyle(color: Color.fromARGB(109, 27, 26, 26)),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  participant.role = value;
                },
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}
