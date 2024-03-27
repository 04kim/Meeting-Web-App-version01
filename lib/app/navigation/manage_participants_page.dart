import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meeting_app/app/share/EditParticipantFrom.dart';

class ManageParticipants extends StatelessWidget {
  final void Function(int) changeMenuContent;
  ManageParticipants({Key? key, required this.changeMenuContent})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 6, 3, 42),
      body: Center(
        child: ManageParticipantsBody(
          changeMenuContent: changeMenuContent,
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class ManageParticipantsBody extends StatefulWidget {
  final void Function(int) changeMenuContent;
  ManageParticipantsBody({
    Key? key,
    required this.changeMenuContent,
  }) : super(key: key);

  @override
  _ManageParticipantsBodyState createState() => _ManageParticipantsBodyState();
}

class _ManageParticipantsBodyState extends State<ManageParticipantsBody> {
  int selectedMenu = 0;

  @override
  void initState() {
    super.initState();
    selectedMenu = 0;
  }

  void _handleSixthButtonPressed() {
    setState(() {
      widget.changeMenuContent(6);
      print(selectedMenu);
    });
  }

  void _handleEditButtonPressed(DocumentSnapshot participant) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditParticipantForm(
          participantId: participant.id,
          fullName: participant['fullName'],
          email: participant['email'],
          description: participant['description'],
          changeMenuContent: widget.changeMenuContent,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.only(top: 10, right: 8),
          alignment: Alignment.topRight,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                _handleSixthButtonPressed(); // Open ParticipantForm
              },
              child: Container(
                height: 40,
                width: 120,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    'Add Participant',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('participants')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return DataTable(
                  headingRowColor: MaterialStateColor.resolveWith(
                      (states) => Color.fromARGB(255, 255, 255, 255)),
                  headingTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Color.fromARGB(
                        255, 3, 1, 26), // Unique styling for column headers
                  ),
                  columns: [
                    DataColumn(label: Text('Full Name')),
                    DataColumn(label: Text('Email')),
                    DataColumn(label: Text('Description')),
                    DataColumn(label: Text('Actions')),
                  ],
                  rows: snapshot.data!.docs.map((participant) {
                    return DataRow(cells: [
                      DataCell(Text(participant['fullName'])),
                      DataCell(Text(participant['email'])),
                      DataCell(Text(participant['description'])),
                      DataCell(Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              // Show confirmation dialog before deleting participant
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Confirm Delete'),
                                    content: Text(
                                        'Are you sure you want to delete this participant?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          // Delete participant
                                          FirebaseFirestore.instance
                                              .collection('participants')
                                              .doc(participant.id)
                                              .delete();
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Delete'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              _handleEditButtonPressed(participant);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.qr_code),
                            onPressed: () {
                              // Generate QR code for participant info
                              // Implement QR code generation functionality
                            },
                          ),
                        ],
                      )),
                    ]);
                  }).toList(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
