import 'package:flutter/material.dart';

class MeetingTopic {
  String topicName = '';
  String resposiblePersonName = '';
  String timeDuration = '';
  TimeOfDay? selectedMeetingStartTime;
  TimeOfDay? selectedMeetingEndTime;
}

class MeetingTopicWidget extends StatelessWidget {
  final MeetingTopic topic;
  final VoidCallback onDelete;

  MeetingTopicWidget({
    required this.topic,
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
                  hintText: 'ຊື່ຫົວຂໍ້',
                  hintStyle: TextStyle(color: Color.fromARGB(109, 27, 26, 26)),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  topic.topicName = value;
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
                  hintText: 'ຜູ້ຮັບຜິດຊອບ',
                  hintStyle: TextStyle(color: Color.fromARGB(109, 27, 26, 26)),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  topic.resposiblePersonName = value;
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
                  hintText: 'ເວລາເລີ່ມ - ເວລາຈົບ',
                  hintStyle: TextStyle(color: Color.fromARGB(109, 27, 26, 26)),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  topic.timeDuration = value;
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
