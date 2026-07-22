import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const DateTimeApp());
}

class DateTimeApp extends StatelessWidget {
  const DateTimeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Date & Time App",
      theme: ThemeData(primarySwatch: const Color.fromARGB(255, 87, 108, 230)),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime currentDateTime = DateTime.now();

  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  Future<void> pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: currentDateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  Future<void> pickTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }

  Widget buildCard({
    required IconData icon,
    required Color color,
    required String title,
    required String value,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Card(
        elevation: 8,
        shadowColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(color: color, width: 2),
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: color,
            child: Icon(icon, color: Colors.white),
          ),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(value, style: const TextStyle(fontSize: 16)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String currentDate = DateFormat('dd MMMM yyyy').format(currentDateTime);

    String currentTime = DateFormat('hh:mm a').format(currentDateTime);

    String formattedDate = selectedDate == null
        ? "No Date Selected"
        : DateFormat('EEEE, dd MMMM yyyy').format(selectedDate!);

    String formattedTime = selectedTime == null
        ? "No Time Selected"
        : selectedTime!.format(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Date & Time App"),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Current Date Card
            buildCard(
              icon: Icons.calendar_today,
              color: Colors.blue,
              title: "Current Date",
              value: currentDate,
              onTap: () {
                setState(() {
                  currentDateTime = DateTime.now();
                });
              },
            ),

            const SizedBox(height: 15),

            // Current Time Card
            buildCard(
              icon: Icons.access_time,
              color: Colors.green,
              title: "Current Time",
              value: currentTime,
              onTap: () {
                setState(() {
                  currentDateTime = DateTime.now();
                });
              },
            ),

            const SizedBox(height: 15),

            // Selected Date Card
            buildCard(
              icon: Icons.date_range,
              color: Colors.orange,
              title: "Selected Date",
              value: formattedDate,
            ),

            const SizedBox(height: 10),

            Center(
              child: SizedBox(
                width: 150,
                height: 45,
                child: ElevatedButton.icon(
                  onPressed: pickDate,
                  icon: const Icon(Icons.calendar_month, size: 18),
                  label: const Text("Pick Date"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Selected Time Card
            buildCard(
              icon: Icons.watch_later,
              color: Colors.purple,
              title: "Selected Time",
              value: formattedTime,
            ),

            const SizedBox(height: 10),

            Center(
              child: SizedBox(
                width: 150,
                height: 45,
                child: ElevatedButton.icon(
                  onPressed: pickTime,
                  icon: const Icon(Icons.access_time, size: 18),
                  label: const Text("Pick Time"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
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
