import 'package:flutter/material.dart';
import 'package:meeting_app/app/navigation/manage_meeting_page.dart';
import 'package:meeting_app/app/navigation/manage_meetingroom_page.dart';
import 'package:meeting_app/app/navigation/manage_participants_page.dart';
import 'package:meeting_app/app/navigation/meeting_room_form.dart';
import 'package:meeting_app/app/navigation/participant_form.dart';

import 'manage_meeting_form1.dart';

class MenuSettingContent extends StatefulWidget {
  final int selectedMenu;
  final void Function(int) changeMenuContent;
  MenuSettingContent(this.selectedMenu, this.changeMenuContent);
  @override
  _MenuSettingContentState createState() => _MenuSettingContentState();
}

class _MenuSettingContentState extends State<MenuSettingContent> {
  @override
  Widget build(BuildContext context) {
    Widget content;

    if (widget.selectedMenu == 0) {
      // Use widget.selectedMenu
      content = Container(
          color: const Color.fromARGB(255, 255, 255, 255)); // Default content
    } else if (widget.selectedMenu == 1) {
      // Use widget.selectedMenu
      content = ManageMeetingPage(
          changeMenuContent:
              widget.changeMenuContent); // Replace with your custom widget
    } else if (widget.selectedMenu == 2) {
      // Use widget.selectedMenu
      content = ManageMeetingroomPage(
          changeMenuContent:
              widget.changeMenuContent); // Replace with another custom widget
    } else if (widget.selectedMenu == 3) {
      // Use widget.selectedMenu
      content = ManageMeetingForm1(changeMenuContent: widget.changeMenuContent);
    } else if (widget.selectedMenu == 4) {
      // Use widget.selectedMenu
      content = ManageParticipants(changeMenuContent: widget.changeMenuContent);
    } else if (widget.selectedMenu == 5) {
      // Use widget.selectedMenu
      content = MeetingRoomForm(changeMenuContent: widget.changeMenuContent);
    } else if (widget.selectedMenu == 6) {
      // Use widget.selectedMenu
      content = ParticipantForm(changeMenuContent: widget.changeMenuContent);
    } else {
      content = Container(); // Default fallback
    }

    return content;
  }
}
