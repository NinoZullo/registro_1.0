import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:registro/mysql/DBMetodi.dart';

//Pagina terminata ed Ottimizzata ✅

class InserisciVoto extends StatefulWidget {
  final int idStudente;

  const InserisciVoto({Key? key, required this.idStudente}) : super(key: key);

  @override
  State<InserisciVoto> createState() => _InserisciVotoState();
}

class _InserisciVotoState extends State<InserisciVoto> {
  final TextEditingController _dataInserimentoController =
      TextEditingController();
  final TextEditingController _idAssegnazioneController =
      TextEditingController();
  final DBMetodi _db = DBMetodi();

  double _votoSelezionato = 5.0;
  String _tipoSelezionato = 'Orale';
  final List<double> _voti = [
    1.0,
    1.25,
    1.5,
    1.75,
    2.0,
    2.25,
    2.5,
    2.75,
    3.0,
    3.25,
    3.5,
    3.75,
    4.0,
    4.25,
    4.5,
    4.75,
    5.0,
    5.25,
    5.5,
    5.75,
    6.0,
    6.25,
    6.5,
    6.75,
    7.0,
    7.25,
    7.5,
    7.75,
    8.0,
    8.25,
    8.5,
    8.75,
    9.0,
    9.25,
    9.5,
    9.75,
    10.0
  ];
  final List<String> _tipi = ['Orale', 'Scritto', 'Pratico'];

  @override
  void dispose() {
    _dataInserimentoController.dispose();
    _idAssegnazioneController.dispose();
    super.dispose();
  }

  Future<void> _mostraDialogoSuccesso() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Caricato!",
            style: GoogleFonts.roboto(color: Colors.green, fontSize: 18.sp),
          ),
          content: Text(
            "Voto inserito con successo",
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

  void _inserisciVoto() {
    final voto = _votoSelezionato;
    final dataInserimento = _dataInserimentoController.text;
    final idStudente = widget.idStudente.toString();
    final idAssegnazione = int.tryParse(_idAssegnazioneController.text) ?? 0;
    final tipo = _tipi.indexOf(_tipoSelezionato);

    if (dataInserimento.isNotEmpty && idAssegnazione != 0) {
      _db.addVoto(voto, dataInserimento, idStudente, idAssegnazione, tipo);
      _dataInserimentoController.clear();
      _idAssegnazioneController.clear();
      _mostraDialogoSuccesso();
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Errore"),
            content:
                const Text("Per favore, compila tutti i campi correttamente."),
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

  bool _isCampoVuoto(String value) {
    return value.trim().isEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Inserisci Voto"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<double>(
              value: _votoSelezionato,
              onChanged: (double? newValue) {
                setState(() {
                  _votoSelezionato = newValue!;
                });
              },
              decoration: const InputDecoration(
                labelText: "Voto",
                border: OutlineInputBorder(),
              ),
              style: GoogleFonts.roboto(color: Colors.black),
              items: _voti.map<DropdownMenuItem<double>>((double value) {
                return DropdownMenuItem<double>(
                  value: value,
                  child: Text(value.toString()),
                );
              }).toList(),
              validator: (value) {
                if (value == null) {
                  return "Il campo voto è obbligatorio.";
                }
                return null;
              },
            ),
            SizedBox(height: 16.h),
            DropdownButtonFormField<String>(
              value: _tipoSelezionato,
              onChanged: (String? newValue) {
                setState(() {
                  _tipoSelezionato = newValue!;
                });
              },
              decoration: const InputDecoration(
                labelText: "Tipo",
                border: OutlineInputBorder(),
              ),
              style: GoogleFonts.roboto(color: Colors.black),
              items: _tipi.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              validator: (value) {
                if (value == null) {
                  return "Il campo tipo è obbligatorio.";
                }
                return null;
              },
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
                      _dataInserimentoController.text =
                          selectedDate.toString().substring(0, 10);
                    });
                  }
                });
              },
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: "Data Inserimento",
                  border: OutlineInputBorder(),
                ),
                child: Text(
                  _dataInserimentoController.text.isNotEmpty
                      ? "Data Inserimento: ${_dataInserimentoController.text}"
                      : "Seleziona una data di inserimento",
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            TextFormField(
              controller: _idAssegnazioneController,
              decoration: const InputDecoration(
                labelText: "ID Assegnazione",
                border: OutlineInputBorder(),
              ),
              style: GoogleFonts.roboto(color: Colors.black),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (_isCampoVuoto(value!)) {
                  return "Il campo ID assegnazione è obbligatorio.";
                }
                return null;
              },
            ),
            SizedBox(height: 16.h),
            ElevatedButton(
              onPressed: _inserisciVoto,
              child: const Text("Inserisci"),
            ),
          ],
        ),
      ),
    );
  }
}
