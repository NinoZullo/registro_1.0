import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:google_fonts/google_fonts.dart";
import "package:registro/mysql/DBMetodi.dart";
//Pagina terminata ed Ottimizzata ✅

class InserisciAssenza extends StatefulWidget {
  final int idStudente;
  const InserisciAssenza({Key? key, required this.idStudente})
      : super(key: key);

  @override
  State<InserisciAssenza> createState() => _InserisciAssenzaState();
}

class _InserisciAssenzaState extends State<InserisciAssenza> {
  final TextEditingController _dataInizioController = TextEditingController();
  final TextEditingController _dataFineController = TextEditingController();
  final DBMetodi _db = DBMetodi();

  int _selectedGiustificata = 0;

  @override
  void dispose() {
    _dataInizioController.dispose();
    _dataFineController.dispose();
    super.dispose();
  }

  Future<void> _showSuccessDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Caricato!",
            style: GoogleFonts.roboto(color: Colors.green, fontSize: 18.sp),
          ),
          content: Text(
            "Assenza inserita con successo",
            style: GoogleFonts.roboto(color: Colors.black, fontSize: 16.sp),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _insertAssenza() {
    final giustificata = _selectedGiustificata;
    final dataInizio = _dataInizioController.text;
    final dataFine = _dataFineController.text;

    if (dataInizio.isNotEmpty && dataFine.isNotEmpty) {
      _db.addAssenza(giustificata, dataInizio, dataFine, widget.idStudente);
      _dataInizioController.clear();
      _dataFineController.clear();
      _showSuccessDialog();
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Errore",
              style: GoogleFonts.roboto(color: Colors.red),
            ),
            content: Text(
              "Per favore, compila tutti i campi correttamente.",
              style: GoogleFonts.roboto(color: Colors.black),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Inserisci Assenza"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<int>(
              value: _selectedGiustificata,
              onChanged: (int? newValue) {
                setState(() {
                  _selectedGiustificata = newValue!;
                });
              },
              decoration: const InputDecoration(
                labelText: "Giustificata",
                border: OutlineInputBorder(),
              ),
              items: [
                DropdownMenuItem<int>(
                  value: 0,
                  child: Text("Non Giustificata",
                      style: GoogleFonts.roboto(color: Colors.black)),
                ),
                DropdownMenuItem<int>(
                  value: 1,
                  child: Text("Giustificata",
                      style: GoogleFonts.roboto(color: Colors.black)),
                ),
              ],
              validator: (value) {
                if (value == null) {
                  return "Il campo giustificata è obbligatorio.";
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: () {
                showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                ).then((selectedDate) {
                  if (selectedDate != null) {
                    setState(() {
                      _dataInizioController.text =
                          selectedDate.toString().substring(0, 10);
                    });
                  }
                });
              },
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: "Data Inizio",
                  border: OutlineInputBorder(),
                ),
                child: Text(
                  _dataInizioController.text.isNotEmpty
                      ? "Data Inizio: ${_dataInizioController.text}"
                      : "Seleziona una data di inizio",
                  style: GoogleFonts.roboto(color: Colors.black),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            InkWell(
              onTap: () {
                showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                ).then((selectedDate) {
                  if (selectedDate != null) {
                    setState(() {
                      _dataFineController.text =
                          selectedDate.toString().substring(0, 10);
                    });
                  }
                });
              },
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: "Data Fine",
                  border: OutlineInputBorder(),
                ),
                child: Text(
                  _dataFineController.text.isNotEmpty
                      ? "Data Fine: ${_dataFineController.text}"
                      : "Seleziona una data di fine",
                  style: GoogleFonts.roboto(color: Colors.black),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _insertAssenza,
              child: const Text("Inserisci"),
            ),
          ],
        ),
      ),
    );
  }
}
