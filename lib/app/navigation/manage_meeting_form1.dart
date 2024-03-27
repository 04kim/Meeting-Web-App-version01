import 'package:flutter/material.dart';
import 'package:meeting_app/app/share/participants_list_field.dart';
import 'package:meeting_app/app/share/meeting_topic_list_field.dart';

class ManageMeetingForm1 extends StatefulWidget {
  final void Function(int) changeMenuContent;
  ManageMeetingForm1({required this.changeMenuContent});
  @override
  _ManageMeetingForm1State createState() => _ManageMeetingForm1State();
}

class _ManageMeetingForm1State extends State<ManageMeetingForm1> {
  DateTimeRange? selectedDateRange;
  int selectedMenu = 0;
  String? selectedMeetingLocation;
  String? selectedMeetingRoom;
  TimeOfDay? selectedMeetingStartTime;
  TimeOfDay? selectedMeetingEndTime;
  DateTime? selectedMeetingDate;

  List<MeetingParticipant> participants = [];
  List<MeetingTopic> topics = [];

  @override
  void initState() {
    super.initState();
    selectedMenu = 0;
  }

  void _handleBackButtonPressed() {
    setState(() {
      widget.changeMenuContent(1);
      print(selectedMenu);
    });
  }

  @override
  Widget build(BuildContext context) {
    Color? textColor = Theme.of(context).brightness == Brightness.light
        ? Colors.black
        : Colors.white;

    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 6, 3, 42),
        child: Column(
          children: [
            Container(
              color: Theme.of(context).primaryColor,
              child: Divider(
                thickness: 2,
                color: Colors.white,
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              color: Color.fromARGB(255, 6, 3, 42),
              child: Row(
                children: [
                  GestureDetector(
                    child: BackButton(onPressed: _handleBackButtonPressed),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'ການສ້າງການປະຊຸມ',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(40),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ຫົວຂໍ້ການປະຊຸມ',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(height: 15),
                      Container(
                        width: 400,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(219, 255, 255, 255),
                          border: Border.all(
                              color: const Color.fromARGB(255, 255, 251, 251)),
                          borderRadius: BorderRadius.circular(0),
                        ),
                        child: TextField(
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            hintText: ' ປ້ອນຫົວຂໍ້ການປະຊຸມ',
                            hintStyle: TextStyle(
                                color: Color.fromARGB(109, 27, 26, 26)),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(height: 35),
                      Text(
                        'ສະຖານທີ່ປະຊຸມ',
                        style: TextStyle(fontSize: 25),
                      ),
                      SizedBox(height: 15),
                      Row(
                        children: [
                          Radio(
                            value: 'Inside',
                            groupValue: selectedMeetingLocation,
                            onChanged: (value) {
                              setState(() {
                                selectedMeetingLocation = value.toString();
                              });
                            },
                          ),
                          Text('ໃນສະຖານທີ່'),
                          SizedBox(width: 10),
                          Radio(
                            value: 'Outside',
                            groupValue: selectedMeetingLocation,
                            onChanged: (value) {
                              setState(() {
                                selectedMeetingLocation = value.toString();
                              });
                            },
                          ),
                          Text('ນອກສະຖານທີ່'),
                        ],
                      ),
                      SizedBox(height: 35),
                      Text(
                        'ຊື່ບ່ອນປະຊຸມ',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(height: 15),
                      DropdownButton<String>(
                        value: selectedMeetingRoom,
                        onChanged: (value) {
                          setState(() {
                            selectedMeetingRoom = value;
                          });
                        },
                        items: <String>[
                          'ຫ້ອງປະຊຸມ 1',
                          'ຫ້ອງປະຊຸມ 2',
                          'ຫ້ອງປະຊຸມ 3 VIP',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 35),
                      Text(
                        'ເວລາປະຊຸມ',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(height: 15),
                      GestureDetector(
                        onTap: () async {
                          TimeOfDay? startTime = await showTimePicker(
                            context: context,
                            initialTime:
                                selectedMeetingStartTime ?? TimeOfDay.now(),
                          );
                          if (startTime != null) {
                            TimeOfDay? endTime = await showTimePicker(
                              context: context,
                              initialTime:
                                  selectedMeetingEndTime ?? TimeOfDay.now(),
                            );
                            if (endTime != null) {
                              setState(() {
                                selectedMeetingStartTime = startTime;
                                selectedMeetingEndTime = endTime;
                              });
                            }
                          }
                        },
                        child: Container(
                          width: 300,
                          height: 40,
                          decoration: BoxDecoration(
                              border: Border.all(), color: Colors.white),
                          padding: EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: TextField(
                                  enabled: false,
                                  style: TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    hintText: selectedMeetingStartTime !=
                                                null &&
                                            selectedMeetingEndTime != null
                                        ? ' ${selectedMeetingStartTime!.format(context)} - ${selectedMeetingEndTime!.format(context)}'
                                        : ' ປ້ອນຊ່ວງເວລາເລີີ່ມ-ຈົບການປະຊຸມ',
                                    hintStyle: TextStyle(
                                        color: Color.fromARGB(109, 27, 26, 26)),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.access_time,
                                color: Color.fromARGB(109, 27, 26, 26),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 35),
                      Text(
                        'ວັນທີ່ປະຊຸມ',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(height: 15),
                      GestureDetector(
                        onTap: () async {
                          final DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2101),
                          );
                          if (pickedDate != null) {
                            setState(() {
                              selectedMeetingDate = pickedDate;
                            });
                          }
                        },
                        child: Container(
                          width: 300,
                          height: 40,
                          decoration: BoxDecoration(
                              border: Border.all(), color: Colors.white),
                          padding: EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: TextField(
                                  enabled: false,
                                  style: TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    hintText: selectedMeetingDate != null
                                        ? selectedMeetingDate!
                                            .toLocal()
                                            .toString()
                                            .split(' ')[0]
                                        : ' ປ້ອນວັນທີ່ຈັດການປະຊຸມ',
                                    hintStyle: TextStyle(
                                        color: Color.fromARGB(109, 27, 26, 26)),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.calendar_today,
                                color: Color.fromARGB(109, 27, 26, 26),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 35),
                      Text(
                        'ປະທານການປະຊຸມ',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(height: 15),
                      Container(
                        width: 400,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(219, 255, 255, 255),
                          border: Border.all(
                              color: const Color.fromARGB(255, 255, 251, 251)),
                          borderRadius: BorderRadius.circular(0),
                        ),
                        child: TextField(
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            hintText: ' ປ້ອນຊື່ປະທານການປະຊຸມ',
                            hintStyle: TextStyle(
                                color: Color.fromARGB(109, 27, 26, 26)),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(height: 35),
                      Text(
                        'ຜູ້ຄວບຄຸມການປະຊຸມ',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(height: 15),
                      Container(
                        width: 400,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(219, 255, 255, 255),
                          border: Border.all(
                              color: const Color.fromARGB(255, 255, 251, 251)),
                          borderRadius: BorderRadius.circular(0),
                        ),
                        child: TextField(
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            hintText: ' ປ້ອນຊື່ຜູ້ຄວບຄຸມການປະຊຸມ',
                            hintStyle: TextStyle(
                                color: Color.fromARGB(109, 27, 26, 26)),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(height: 35),
                      Text(
                        'ຜູ້ເຂົ້າຮ່ວມປະຊຸມ',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(height: 15),
                      Column(
                        children: participants
                            .map((participant) => MeetingParticipantWidget(
                                  participant: participant,
                                  onDelete: () {
                                    setState(() {
                                      participants.remove(participant);
                                    });
                                  },
                                ))
                            .toList(),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            participants.add(MeetingParticipant());
                          });
                        },
                        icon: Icon(Icons.add),
                        label: Text(
                          'ເພີ່ມຜູ້ເຂົ້າຮ່ວມ',
                        ),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blue,
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(1),
                          ),
                        ),
                      ),
                      SizedBox(height: 35),
                      Text(
                        'ຫົວຂໍ້ການປະຊຸມ',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(height: 15),
                      Column(
                        children: topics
                            .map((topic) => MeetingTopicWidget(
                                  topic: topic,
                                  onDelete: () {
                                    setState(() {
                                      participants.remove(topic);
                                    });
                                  },
                                ))
                            .toList(),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            topics.add(MeetingTopic());
                          });
                        },
                        icon: Icon(Icons.add),
                        label: Text(
                          'ເພີ່ມຫົວຂໍ້',
                        ),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blue,
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(1),
                          ),
                        ),
                      ),
                    ],
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
