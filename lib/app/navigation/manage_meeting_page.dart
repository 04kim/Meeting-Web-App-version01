import 'package:flutter/material.dart';

class ManageMeetingPage extends StatefulWidget {
  final void Function(int) changeMenuContent;

  ManageMeetingPage({required this.changeMenuContent});
  @override
  _ManageMeetingPageState createState() => _ManageMeetingPageState();
}

class _ManageMeetingPageState extends State<ManageMeetingPage> {
  DateTimeRange? selectedDateRange;
  int selectedMenu = 0;
  @override
  void initState() {
    super.initState();
    selectedMenu = 0;
  }

  void _handleThirdButtonPressed() {
    setState(() {
      widget.changeMenuContent(3);
      print(selectedMenu);
    });
  }

  @override
  Widget build(BuildContext context) {
    Color? textColor = Theme.of(context).brightness == Brightness.light
        ? Colors.black // Use black text color for light theme
        : Colors.white; // Use white text color for dark theme

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
              color: Theme.of(context).primaryColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'ຄົ້ນຫາ:',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 2, vertical: 0),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(219, 255, 255, 255),
                        border: Border.all(
                            color: const Color.fromARGB(255, 255, 251, 251)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextField(
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          hintText: 'ຄົ້ນຫາ....',
                          hintStyle:
                              TextStyle(color: Color.fromARGB(109, 27, 26, 26)),
                          prefixIcon: Icon(Icons.search),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  Text(
                    'ວັນທິ່ປະຊຸມ:',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  SizedBox(width: 8),
                  Flexible(
                    child: GestureDetector(
                      onTap: () async {
                        final DateTimeRange? picked = await showDateRangePicker(
                          context: context,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );

                        if (picked != null) {
                          setState(() {
                            selectedDateRange = picked;
                          });
                        }
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 2, vertical: 0),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(219, 255, 255, 255),
                          border: Border.all(
                            color: const Color.fromARGB(255, 255, 251, 251),
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: TextField(
                                enabled: false, // To prevent editing
                                decoration: InputDecoration(
                                  hintText: selectedDateRange != null
                                      ? '${selectedDateRange!.start.day}/${selectedDateRange!.start.month}/${selectedDateRange!.start.year} - ${selectedDateRange!.end.day}/${selectedDateRange!.end.month}/${selectedDateRange!.end.year}'
                                      : '',
                                  hintStyle: TextStyle(color: Colors.black),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(
                              Icons.calendar_today,
                              color: Color.fromARGB(109, 27, 26, 26),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                ],
              ),
            ),
            SizedBox(height: 5),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'ລາຍການປະຊຸມ',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          _handleThirdButtonPressed();
                        },
                        icon: Icon(Icons.add),
                        label: Text(
                          'ສ້າງການປະຊຸມ',
                        ),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blue,
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Table(
                    border: TableBorder.all(color: Colors.white),
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: [
                      TableRow(
                        decoration: BoxDecoration(
                            color: Color.fromARGB(219, 255, 255, 255)),
                        children: [
                          TableCell(
                            child: Center(
                                child: Text(
                              'ຫົວຂໍ້ການປະຊຸມ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                          ),
                          TableCell(
                            child: Center(
                                child: Text('ວັນທີ່ປະຊຸມ',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ))),
                          ),
                          TableCell(
                            child: Center(
                                child: Text('ເວລາປະຊຸມ',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ))),
                          ),
                          TableCell(
                            child: Center(
                                child: Text('ຄູ່ປະຊຸມ',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ))),
                          ),
                          TableCell(
                            child: Center(
                                child: Text('ສະຖານທີ່ປະຊຸມ',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ))),
                          ),
                          TableCell(
                            child: Center(
                                child: Text('ປະທານການປະຊຸມ',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ))),
                          ),
                          TableCell(
                            child: Center(
                                child: Text('ຜູ້ເຂົ້າຮ່ວມການປະຊຸມ',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ))),
                          ),
                          TableCell(
                            child: Center(
                                child: Text('ຫົວຂໍ້ຈະປະຊຸມກັນ',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ))),
                          ),
                          TableCell(
                            child: Center(
                                child: Text('ຜູ້ບັນທຶກການປະຊຸມ',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ))),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          TableCell(
                            child: Center(child: Text('')),
                          ),
                          TableCell(
                            child: Center(child: Text('')),
                          ),
                          TableCell(
                            child: Center(child: Text('')),
                          ),
                          TableCell(
                            child: Center(child: Text('')),
                          ),
                          TableCell(
                            child: Center(child: Text('')),
                          ),
                          TableCell(
                            child: Center(child: Text('')),
                          ),
                          TableCell(
                            child: Center(child: Text('')),
                          ),
                          TableCell(
                            child: Center(child: Text('')),
                          ),
                          TableCell(
                            child: Center(child: Text('')),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
