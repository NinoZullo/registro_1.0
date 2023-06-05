import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:google_fonts/google_fonts.dart";
import "package:registro/mysql/DBMetodi.dart";

//Pagina terminata ed Ottimizzata ✅

class InserisciNota extends StatefulWidget {
  final int idStudente;
  final int idDocente;

  const InserisciNota({
    Key? key,
    required this.idStudente,
    required this.idDocente,
  }) : super(key: key);

  @override
  State<InserisciNota> createState() => _InserisciNotaState();
}

class _InserisciNotaState extends State<InserisciNota> {
  final TextEditingController _descrizioneController = TextEditingController();
  DateTime? _selectedDate;
  DBMetodi db = DBMetodi();

  @override
  void dispose() {
    _descrizioneController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _addNota() async {
    String descrizione = _descrizioneController.text.trim(); // Trim leading and trailing whitespace
    String dataInserimento =
    _selectedDate != null ? _selectedDate.toString() : "";
    int idStudente = widget.idStudente;
    int idDocente = widget.idDocente;

    if (descrizione.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Errore"),
            content: Text(
              "La descrizione non può essere vuota!",
              style: GoogleFonts.roboto(color: Colors.black),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return; // Exit the method if the description is empty
    }

    db.addNota(descrizione, dataInserimento, idStudente, idDocente);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Nota Aggiunta"),
          content: Text(
            "Nota aggiunta con successo!",
            style: GoogleFonts.roboto(color: Colors.black),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Inserisci Nota"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: Colors.grey[200],
              ),
              child: TextField(
                controller: _descrizioneController,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  labelText: "Descrizione",
                  labelStyle: GoogleFonts.roboto(color: Colors.black),
                ),
                maxLines: 3,
              ),
            ),
            const SizedBox(height: 10.0),
            Container(
              color: Colors.grey[200],
              child: ListTile(
                title: Text(
                  _selectedDate != null
                      ? "Data Inserimento: ${_selectedDate!.toString().substring(0, 10)}"
                      : "Seleziona Data Inserimento",
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                  ),
                ),
                trailing: const Icon(Icons.calendar_today),
                onTap: () {
                  _selectDate(context);
                },
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _addNota,
              child: const Text("Aggiungi Nota"),
            ),
          ],
        ),
      ),
    );
  }
}
