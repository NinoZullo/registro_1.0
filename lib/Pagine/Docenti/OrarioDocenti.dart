import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:registro/Pagine/Docenti/HomePageDocenti.dart';
import 'package:registro/Pagine/Docenti/Classi.dart';
import 'package:registro/metodi/Metodi.dart';

import '../../mysql/DBMetodi.dart';

class OrarioDocenti extends StatefulWidget {
  const OrarioDocenti({Key? key}) : super(key: key);

  @override
  State<OrarioDocenti> createState() => _OrarioDocentiState();
}

class _OrarioDocentiState extends State<OrarioDocenti> {
  int _selectedIndex = 2;
  int _currentDayIndex = 0;
  List<String> _days = [
    'Lun',
    'Mar',
    'Mer',
    'Gio',
    'Ven',
    'Sab',
  ];
  List<String> _hours = [
    '8:00',
    '9:00',
    '10:00',
    '11:00',
    '12:00',
    '13:00',
    '14:00',
    '15:00',
    '16:00',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<List<Map<String, dynamic>>?> getOreDocenti() async {
    DBMetodi db = DBMetodi();
    return db.getOreDocenti();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_days[_currentDayIndex] + ' - Orario Docenti'),
      ),
      body: Column(
        children: [
          _buildTimeRow(),
          Expanded(
            child: ListView.builder(
              itemCount: _hours.length,
              itemBuilder: (context, index) {
                return _buildTableRow(_hours[index]);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(
            label: "Classi",
            icon: Icon(Icons.people_alt_rounded),
          ),
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: "Orari",
            icon: Icon(Icons.lock_clock),
          ),
        ],
        onTap: (currentIndex) {
          switch (currentIndex) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Classi(),
                ),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePageDocenti(),
                ),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrarioDocenti(),
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

  Widget _buildTimeRow() {
    return Container(
      height: 40,
      color: Colors.grey,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _days.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                _currentDayIndex = index;
              });
            },
            child: Container(
              width: 80,
              color: index == _currentDayIndex ? Colors.blue : Colors.transparent,
              child: Center(
                child: Text(
                  _days[index],
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: index == _currentDayIndex ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTableRow(String time) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder<List<Map<String, dynamic>>?>(
        future: getOreDocenti(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Errore durante il recupero dei dati');
          } else if (snapshot.hasData) {
            final oreDocenti = snapshot.data!;
            return Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    time,
                    style: TextStyle(fontSize: 16.sp, color: Colors.black),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    height: 40,
                    color: _getHourColor(oreDocenti, time),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: oreDocenti.length,
                      itemBuilder: (context, index) {
                        final classe = oreDocenti[index];
                        final oraInizio = classe['ora_inizio'] as Duration?;
                        final oraFine = classe['ora_fine'] as Duration?;
                        final nomeClasse = classe['nome_classe'] as String;
                        final nomeMateria = classe['nome_materia'] as String;

                        final isWorkingHour = _isCurrentHourWorking(oraInizio, oraFine, time);

                        return ListTile(
                          title: Text(
                            '$nomeClasse - $nomeMateria',
                            style: TextStyle(
                              color: isWorkingHour ? Colors.white : Colors.black,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Text('Nessun dato disponibile');
          }
        },
      ),
    );
  }

  Color _getHourColor(List<Map<String, dynamic>> oreDocenti, String time) {
    for (var ore in oreDocenti) {
      final oraInizio = ore['ora_inizio'] as Duration?;
      final oraFine = ore['ora_fine'] as Duration?;

      if (_isCurrentHourWorking(oraInizio, oraFine, time)) {
        return Colors.green;
      }
    }
    return Colors.grey;
  }

  bool _isCurrentHourWorking(Duration? oraInizio, Duration? oraFine, String time) {
    final currentTime = TimeOfDay.now();

    if (oraInizio != null && oraFine != null) {
      if (currentTime.hour >= oraInizio.inHours && currentTime.hour < oraFine.inHours) {
        return time == '${currentTime.hour}:00';
      }
    }

    return false;
  }
}
