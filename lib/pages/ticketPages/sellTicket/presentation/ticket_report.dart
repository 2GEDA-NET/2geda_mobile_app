import 'package:_2geda/models/ticket.dart';
import 'package:_2geda/pages/ticketPages/sellTicket/services/fetch_ticket_report.dart';
import 'package:flutter/material.dart';

class TicketReport extends StatefulWidget {
  const TicketReport({super.key});

  @override
  State<TicketReport> createState() => _TicketReportState();
}

class _TicketReportState extends State<TicketReport> {
  String selectedValue = 'Option 1';

  // Initial value
  List<String> dropdownItems = ['Option 1', 'Option 2', 'Option 3', 'Option 4'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: const Text(
          'Ticket Report',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/2geda-purple.png'),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            InputDecorator(
              decoration: const InputDecoration(
                labelText: 'Select Event',
                hintText: 'Select event', // Label text
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedValue,
                  icon: const Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedValue = newValue!;
                    });
                  },
                  items: dropdownItems
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: ElevatedButton(
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => const SideBarLayout(),
                  //   ),
                  // );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff4e0ca2),
                  minimumSize: const Size(150, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.download, color: Colors.white),
                    Text(
                      "Get Report",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: BoxDecoration(
                border: Border.all(
                    width: 1, color: const Color.fromARGB(255, 203, 202, 202)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const TicketCSV(),
            ),
            const SizedBox(
              height: 20,
            ),
            Image.asset('assets/banner2.png')
          ],
        ),
      ),
    );
  }
}

class TicketCSV extends StatefulWidget {
  const TicketCSV({super.key,});

  @override
  State<TicketCSV> createState() => _TicketCSVState();
}

class _TicketCSVState extends State<TicketCSV> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Text("Event report",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                )),
            const Spacer(),
            ElevatedButton(
              onPressed: () {},
              child: const Row(
                children: [
                  Icon(Icons.download),
                  Text("Download .CSV",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      )),
                ],
              ),
            ),
          ],
        ),
        
        FutureBuilder<List<TicketReportData>>(
          future: getTicketReport(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(); // Loading indicator while data is being fetched
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Text('No ticket data available');
            } else {
              // Data has been successfully fetched
              return Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      for (TicketReportData ticketData in snapshot.data!)
                        _ticketCSV(ticketData),
                    ],
                  ),
                ),
              );
            }
          },
        )
      ],
    );
  }

  void _showDialog(BuildContext context, TicketReportData ticketData) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              const Text(
                "Ticket details",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                icon: const Icon(Icons.close),
              ),
            ],
          ), // Customize the dialog title

          content: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                width: 1,
                color: const Color.fromARGB(255, 192, 192, 192),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Buyer",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          ticketData.name ?? 'Anonymous',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Ticket ID",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          "ID: ${ticketData.id}",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Divider(),
                const Text(
                  "Ticket status",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Wrap(
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff4e0ca2),
                        minimumSize: const Size(10, 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        "4 ticket",
                        style: TextStyle(
                          fontSize: 7,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8), // Adjust spacing as needed
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(92, 92, 92, 1.0),
                        minimumSize: const Size(10, 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        "2 Regular",
                        style: TextStyle(
                          fontSize: 7,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        minimumSize: const Size(10, 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        "1 VIP",
                        style: TextStyle(
                          fontSize: 7,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromRGBO(237, 108, 48, 1.0),
                        minimumSize: const Size(10, 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        "1 VVIP",
                        style: TextStyle(
                          fontSize: 7,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(),
                Column(
                  children: [
                    const Text(
                      "Amount paid",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      '# ${ticketData.price} ',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                // Add more details as needed
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _ticketCSV(
    TicketReportData ticketData,
  ) {
    return ListTile(
      onTap: () => _showDialog(context, ticketData),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration:
            const BoxDecoration(shape: BoxShape.circle, color: Colors.green),
        child: const Icon(
          Icons.arrow_forward,
          color: Colors.white,
        ),
      ),
      title: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(ticketData.name ?? '',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  )),
              const SizedBox(height: 5),
              Text("ID: ${ticketData.id}",
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                  )),
            ],
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: const Color(0xff4e0ca2),
                borderRadius: BorderRadius.circular(10)),
            child: Text(ticketData.ticketType ?? '',
                style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: Colors.white)),
          ),
          const Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(ticketData.date ?? '',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  )),
              const SizedBox(height: 5),
              Text("# ${ticketData.price}",
                  style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: Colors.green)),
            ],
          ),
        ],
      ),
    );
  }
}
