import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:google_fonts/google_fonts.dart";
import "package:intl/intl.dart";
import "package:registro/Pagine/Widget/HeaderHeight.dart";
import "package:registro/mysql/DBMetodi.dart";
import "package:registro/mysql/Utente.dart";
import "package:registro/Pagine/InfoCompiti.dart";

class Compiti extends StatefulWidget {
  const Compiti({Key? key}) : super(key: key);

  @override
  State<Compiti> createState() => _CompitiState();
}

class _CompitiState extends State<Compiti> {
  List<Map<String, dynamic>>? compiti;
  DBMetodi db = DBMetodi();
  final DateFormat _dateFormat = DateFormat("dd-MM-yyyy");
  final double _headerHeight = 100.h;
  bool isExpanded = false;
  int? selectedIndex;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    compiti = await db.getCompiti(idClasse_!);
    setState(() {});
  }

  void toggleExpandedState(int index) {
    setState(() {
      if (selectedIndex == index) {
        isExpanded = !isExpanded;
      } else {
        isExpanded = true;
      }
      selectedIndex = index;
    });
  }

  void navigateToInfoCompiti(Map<String, dynamic> compito) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => InfoCompiti(compito: compito),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Compiti"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: _headerHeight,
            child: HeaderWidget(_headerHeight),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: compiti != null
                ? ListView.builder(
              itemCount: compiti!.length,
              itemBuilder: (context, index) {
                final compito = compiti![index];
                final scadenza = _dateFormat.format(compito["scadenza"]);

                final materia = compito["nome_materia"];

                final isSelected = isExpanded && selectedIndex == index;

                return ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Icon(
                      Icons.assignment,
                      color: Colors.white,
                    ),
                  ),
                  title: Text(
                    "$materia - Scadenza: $scadenza",
                    style:  GoogleFonts.roboto(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  onTap: () {
                    navigateToInfoCompiti(compito);
                    toggleExpandedState(index);
                  },
                  tileColor: isSelected ? Colors.grey.shade200 : null,
                );
              },
            )
                : const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}
