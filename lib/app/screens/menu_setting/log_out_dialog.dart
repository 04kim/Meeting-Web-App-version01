import 'package:flutter/material.dart';

class LogOutDialog extends StatefulWidget {
  final VoidCallback onLogOut;

  LogOutDialog({required this.onLogOut});

  @override
  _LogOutDialogState createState() => _LogOutDialogState();
}

class _LogOutDialogState extends State<LogOutDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        height: MediaQuery.of(context).size.height * 0.4,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Text(
              'ອອກຈາກລະບົບ',
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(height: 8),
            Text(
              'ທ່ານຕ້ອງການອອກຈາກລະບົບແທ້ບໍ່?',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(120, 40),
                    backgroundColor: Color.fromARGB(37, 30, 27, 27),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.0),
                      side:
                          BorderSide(color: Color.fromARGB(136, 255, 255, 255)),
                    ),
                  ),
                  child: Text('ຍົກເລີກ'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    widget
                        .onLogOut(); // Use widget.onLogOut to access the callback
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(120, 40),
                    backgroundColor: Color.fromARGB(255, 18, 25, 228),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.0),
                      side:
                          BorderSide(color: Color.fromARGB(136, 255, 255, 255)),
                    ),
                  ),
                  child: Text('ຍືນຍັນ'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
