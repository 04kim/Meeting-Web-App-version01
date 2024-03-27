import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:meeting_app/app/share/EditMeetingRoomScreen.dart';

class RoomCard extends StatefulWidget {
  final DocumentSnapshot meetingRoom;
  final String imageAsset;
  final void Function() refreshMeetingRooms;
  const RoomCard({
    Key? key,
    required this.meetingRoom,
    required this.imageAsset,
    required this.refreshMeetingRooms,
  }) : super(key: key);

  @override
  _RoomCardState createState() => _RoomCardState();
}

class _RoomCardState extends State<RoomCard> {
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
              color: Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(15),
            ),
            alignment: AlignmentDirectional(0, 0),
            child: Align(
              alignment: AlignmentDirectional(0, 0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _buildContent(context),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildContent(BuildContext context) {
    return [
      _buildImage(),
      // ignore: deprecated_member_use
      _buildText(
          'Room Name',
          FlutterFlowTheme.of(context).bodyText1,
          widget.meetingRoom['roomName'],
          EdgeInsetsDirectional.fromSTEB(16, 8, 16, 4)),
      // ignore: deprecated_member_use
      _buildText(
          'Room Level',
          FlutterFlowTheme.of(context).bodyText1,
          widget.meetingRoom['roomLevel'],
          EdgeInsetsDirectional.fromSTEB(16, 0, 16, 4)),
      // ignore: deprecated_member_use
      _buildText(
          'Room Description',
          FlutterFlowTheme.of(context).bodyText1,
          widget.meetingRoom['roomDescription'],
          EdgeInsetsDirectional.fromSTEB(16, 0, 16, 8)),
      _buildButtons(context),
    ];
  }

  Widget _buildText(String label, TextStyle style, String text,
      EdgeInsetsDirectional padding) {
    return Padding(
      padding: padding,
      child: Text(
        '$label: $text',
        style: style.copyWith(color: Colors.black),
      ),
    );
  }

  Widget _buildImage() {
    return Container(
      child: kIsWeb
          ? Image.network(
              widget.imageAsset,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
              alignment: Alignment(0, 0),
            )
          : Image.asset(
              widget.imageAsset,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
              alignment: Alignment(0, 0),
            ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 16),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildButtonReport(
              'Report', FlutterFlowTheme.of(context).primary, Colors.white),
          SizedBox(width: 12),
          _buildButtonView(
              'View', FlutterFlowTheme.of(context).primary, Colors.white),
          SizedBox(width: 12),
          _buildButtonEdit('Edit', FlutterFlowTheme.of(context).accent1,
              Color.fromARGB(255, 255, 255, 255)),
          SizedBox(width: 12),
          _buildButtonDelete('Delete', FlutterFlowTheme.of(context).tertiary,
              Color.fromARGB(255, 255, 255, 255)),
        ],
      ),
    );
  }

  Widget _buildButtonView(String text, Color color, Color textColor) {
    return FFButtonWidget(
      onPressed: () {
        if (text == 'View') {
          _showMeetingDialog();
        }
      },
      text: text,
      options: FFButtonOptions(
        width: 80,
        height: 35,
        color: Color.fromARGB(255, 49, 76, 251),
        textStyle: FlutterFlowTheme.of(context).bodyLarge.override(
              fontFamily: 'Readex Pro',
              color: textColor,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
        elevation: 0,
        borderSide: BorderSide(
          color: Colors.transparent,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  Widget _buildButtonReport(String text, Color color, Color textColor) {
    return FFButtonWidget(
      onPressed: () {
        print('');
      },
      text: text,
      options: FFButtonOptions(
        width: 80,
        height: 35,
        color: Color.fromARGB(255, 49, 76, 251),
        textStyle: FlutterFlowTheme.of(context).bodyLarge.override(
              fontFamily: 'Readex Pro',
              color: textColor,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
        elevation: 0,
        borderSide: BorderSide(
          color: Colors.transparent,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  Widget _buildButtonDelete(String text, Color color, Color textColor) {
    return FFButtonWidget(
      onPressed: () {
        _showDeleteConfirmationDialog();
      },
      text: text,
      options: FFButtonOptions(
        width: 80,
        height: 35,
        color: Color.fromARGB(255, 49, 76, 251),
        textStyle: FlutterFlowTheme.of(context).bodyLarge.override(
              fontFamily: 'Readex Pro',
              color: textColor,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
        elevation: 0,
        borderSide: BorderSide(
          color: Colors.transparent,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  Widget _buildButtonEdit(String text, Color color, Color textColor) {
    return FFButtonWidget(
      onPressed: () {
        _editMeetingRoom();
      },
      text: text,
      options: FFButtonOptions(
        width: 80,
        height: 35,
        color: Color.fromARGB(255, 49, 76, 251),
        textStyle: FlutterFlowTheme.of(context).bodyLarge.override(
              fontFamily: 'Readex Pro',
              color: textColor,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
        elevation: 0,
        borderSide: BorderSide(
          color: Colors.transparent,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  void _showMeetingDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Room Details'),
          content: SingleChildScrollView(
            child: DataTable(
              columns: const <DataColumn>[
                DataColumn(
                  label: Text(
                    'Meeting List',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Meeting Date',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Meeting Time',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ],
              rows: const <DataRow>[
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text('Meeting 1')),
                    DataCell(Text('2022-01-01')),
                    DataCell(
                        Text('10:00 AM - 11:00 AM')), // Start time - End time
                  ],
                ),
                // Add more DataRow here for other meetings
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteMeetingRoom() async {
    try {
      await FirebaseFirestore.instance
          .collection('meetingRooms')
          .doc(widget.meetingRoom
              .id) // Assuming 'id' is the field representing document ID
          .delete();
      // Refresh meeting rooms after deletion
      widget.refreshMeetingRooms();
    } catch (e) {
      print('Error deleting meeting room: $e');
      // Handle any errors here
    }
  }

  void _editMeetingRoom() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              EditMeetingRoomScreen(meetingRoom: widget.meetingRoom)),
    ).then((_) {
      // Refresh meeting rooms after editing
      widget.refreshMeetingRooms();
    });
  }

  void _showDeleteConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Delete"),
          content: Text("Are you sure you want to delete this item?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                _deleteMeetingRoom(); // Call delete function
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Delete"),
            ),
          ],
        );
      },
    );
  }
}
