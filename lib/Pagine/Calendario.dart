import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:registro/Pagine/EventManager.dart';
import 'package:registro/Pagine/Eventi.dart';
import 'package:flutter/material.dart';
import 'package:registro/Pagine/HomePage.dart';
import 'package:registro/Pagine/PCTO.dart';
import 'package:registro/Pagine/Profilo.dart';
import 'package:registro/Pagine/menu.dart';
import 'package:registro/metodi/Metodi.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendario extends StatefulWidget {
  @override
  _CalendarioState createState() => _CalendarioState();
}

class _CalendarioState extends State<Calendario> {
  late Map<DateTime, List<Eventi>> selectedEvents;
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  late EventiManager eventiManager;
  int _selectedIndex = 0;
  TextEditingController _eventController = TextEditingController();

  @override
  void initState() {
    selectedEvents = {};
    eventiManager = EventiManager();
    eventiManager.loadEvents().then((loadedEvents) {
      setState(() {
        selectedEvents = loadedEvents;
      });
    });
    super.initState();
  }

  List<Eventi> _getEventsfromDay(DateTime date) {
    return selectedEvents[date] ?? [];
  }

  @override
  void dispose() {
    saveEvents();
    _eventController.dispose();
    super.dispose();
  }

  void saveEvents() {
    eventiManager.saveEvents(selectedEvents);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calendario"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TableCalendar(
            focusedDay: selectedDay,
            firstDay: DateTime(2020),
            lastDay: DateTime(2025),
            calendarFormat: format,
            onFormatChanged: (CalendarFormat _format) {
              setState(() {
                format = _format;
              });
            },
            startingDayOfWeek: StartingDayOfWeek.sunday,
            daysOfWeekVisible: true,
            onDaySelected: (DateTime selectDay, DateTime focusDay) {
              setState(() {
                selectedDay = selectDay;
                focusedDay = focusDay;
              });
              print(focusedDay);
            },
            selectedDayPredicate: (DateTime date) {
              return isSameDay(selectedDay, date);
            },
            eventLoader: _getEventsfromDay,
            calendarStyle: CalendarStyle(
              isTodayHighlighted: true,
              selectedDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
              selectedTextStyle: TextStyle(color: Colors.black),
              todayDecoration: BoxDecoration(
                color: Colors.purpleAccent,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
              defaultDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.white,
              ),
              defaultTextStyle: TextStyle(color: Colors.black),
              weekendDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
              outsideDaysVisible: true,
            ),
            headerStyle: HeaderStyle(
              formatButtonVisible: true,
              titleCentered: true,
              formatButtonShowsNext: false,
              formatButtonDecoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(5.0),
              ),
              formatButtonTextStyle: TextStyle(
                color: Colors.black,
              ),
              titleTextStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
          ),
          SizedBox(height: 10.0),
          Expanded(
            child: ListView.separated(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: _getEventsfromDay(selectedDay).length,
              separatorBuilder: (context, index) => SizedBox(height: 10.0),
              itemBuilder: (context, index) {
                final event = _getEventsfromDay(selectedDay)[index];
                final eventDate = selectedDay;
                return Padding(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Container(
                    child: Text(
                        "${event.title}\n${eventDate.day}/${eventDate.month}/${eventDate.year}"),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              "Aggiungi evento",
              style: TextStyle(color: Colors.black),
            ),
            content: TextFormField(
              controller: _eventController,
              decoration: InputDecoration(
                hintText: "Inserisci l'evento",
                hintStyle: TextStyle(color: Colors.grey),
              ),
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              TextButton(
                child: Text("Cancel"),
                onPressed: () => Navigator.pop(context),
              ),
              TextButton(
                child: Text("Ok"),
                onPressed: () {
                  if (_eventController.text.isNotEmpty) {
                    final event = Eventi(title: _eventController.text);
                    selectedEvents[selectedDay] = [
                      ..._getEventsfromDay(selectedDay),
                      event,
                    ];
                    setState(() {});
                  }
                  Navigator.pop(context);
                  _eventController.clear();
                },
              ),
            ],
          ),
        ),
        label: Text("Aggiungi evento"),
        icon: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        items: [
          It("Calendario", Icons.calendar_month),
          It("Menù", Icons.menu),
          It("Home", Icons.home),
          It("PCTO", Icons.engineering),
          It("Profilo", Icons.person),
        ],
        onTap: (currentIndex) {
          switch (currentIndex) {
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => menu(),
                ),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>  HomePage(),
                ),
              );
              break;
            case 3:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PCTO(),
                ),
              );
              break;
            case 4:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => profilo(),
                ),
              );
              break;
          }
        },
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
