import 'Mysql.dart';
import 'Utente.dart';

class DBMetodi {

  Mysql db = Mysql();

  Future<bool> login(String username, String password) async {
    var db = Mysql();
    final conn = await db.getConnection();
    // viene cercato l'account in basa a nome utente e password
    var results = await conn.query(
        "SELECT * "
            "FROM accounts "
            "WHERE nome_utente = '$username' AND pass = '$password'");
    if (results.isEmpty) {
      // se non viene trovato nulla il login fallisce
      await conn.close();
      return false;
    } else {
      // se viene trivata una corrispondenza i deti dell'account vendgono salvati
      var list = results.toList();
      idAccount_ = list[0][0];
      userName_ = list[0][1];
      password_ = list[0][2];
      // si cerca se l'account è di uno studente
      results = await conn.query(
          "SELECT * "
              "FROM studenti "
              "INNER JOIN classi ON studenti.id_classe = classi.id_classe "
              "WHERE id_account = '$idAccount_'");
      // se è di uno studente i dati vengono salvati
      if (results.isNotEmpty) {
        list = results.toList();
        isStudente_ = true;
        idUtente_ = list[0][0];
        nome_ = list[0][1];
        cognome_ = list[0][2];
        dataDiNascita_ = list[0][3];
        idClasse_ = list[0][5];
        classe_ = list[0][8];
      } else {
        // se non è di uno studente allora si cerca tra i professori
        results = await conn.query(""
            "SELECT * "
            "FROM docenti "
            "WHERE id_account = '$idAccount_'");
        if (results.isNotEmpty) {
          // se vengono trovati dei dati vengono salvati e il login viene effettuato come docente
          list = results.toList();
          isStudente_ = false;
          idUtente_ = list[0][0];
          nome_ = list[0][1];
          cognome_ = list[0][2];
          dataDiNascita_ = null;
          classe_ = null;
        } else {
          // se non viene trovato nulla nei docenti il login fallisce
          await conn.close();
          return false;
        }
      }
      await conn.close();
      return true;
    }
  }

/*
formato:
- int voto,
- String tipo = ("P", "O", "S")
- String descrizione
- DateTime data (yyyy-mm-gg hh-mm-ss)
- String nome
- String cognome
- String materia
 */
  Future<List<Map<String, dynamic>>?> getVoti() async {
    var db = Mysql();
    final conn = await db.getConnection();
    var results = await conn.query(
        "SELECT voto, tipo, descrizione, data_inserimento, nome, cognome, nome_materia "
            "FROM voti "
            "INNER JOIN assegnazioni ON voti.id_assegnazione = assegnazioni.id_assegnazione "
            "INNER JOIN docenti ON assegnazioni.id_docente = docenti.id_docente "
            "INNER JOIN materie ON assegnazioni.id_materia = materie.id_materia "
            "WHERE voti.id_studente = '$idUtente_'");
    await conn.close();
    return results.map((row) => row.fields).toList();
  }

/*
formato:
- double voto
- String tipo (P, O, S)
- String data_inserimento (yyyy-mm-gg hh:mm:ss)
- int id_studente 
- id_assegnazione 
 */
  void addVoto(double voto, String tipo, String data_inserimento,
      int id_studente, int id_assegnazione) async {
    var db = Mysql();
    final conn = await db.getConnection();
    await conn.query(
        "INSERT INTO voti (voto, tipo, data_inserimento, id_studente, id_assegnazione)"
            "VALUES ($voto, '$tipo', '$data_inserimento', $id_studente, $id_assegnazione);"
    );
    await conn.close();
  }

/*
formato:
- String nome_evento
- String descrizione
- DateTime data_inizio
- DtaeTime data_fine
- String nome_classe
 */
  Future<List<Map<String, dynamic>>?> getEventi(int idClasse) async {
    var db = Mysql();
    final conn = await db.getConnection();
    var results = await conn.query(
        "SELECT nome_evento, descrizione, data_inizio, data_fine, nome_classe "
            "FROM eventi "
            "INNER JOIN classi ON eventi.id_classe = classi.id_classe "
            "WHERE eventi.id_classe = $idClasse");
    await conn.close();
    return results.map((row) => row.fields).toList();
  }

/*
formato:
- String nome_corto (+, -, *, GR, IN, NTS, SU, IN, DI, BU, DST, OT)
- String nome_lungo (Sufficiente, Insufficiente, Ottimo, ecc.)
- String descrizione
- DateTime data_inserimento
- String nome (del docente)
- String cognome (del docente)
- String nome_materia
 */
  Future<List<Map<String, dynamic>>?> getAnnotazioni(int idUtente) async {
    var db = Mysql();
    final conn = await db.getConnection();
    var results = await conn.query(
        "SELECT nome_corto, nome_lungo, descrizione, data_inserimento, nome, cognome, nome_materia "
            "FROM annotazioni "
            "INNER JOIN tipi_annotazioni ON annotazioni.id_tipo = tipi_annotazioni.id_tipo "
            "INNER JOIN assegnazioni ON annotazioni.id_assegnazione = assegnazioni.id_assegnazione "
            "INNER JOIN docenti ON assegnazioni.id_docente = docenti.id_docente "
            "INNER JOIN materie ON assegnazioni.id_materia = materie.id_materia "
            "WHERE annotazioni.id_studente = $idUtente");
    await conn.close();
    return results.map((row) => row.fields).toList();
  }

/*
formato:
- bool giustificata (0 = non giust./1 = giust.)
- DateTime data_inizio
- DateTime data_fine
 */
  Future<List<Map<String, dynamic>>?> getAssenze(int idUtente) async {
    var db = Mysql();
    final conn = await db.getConnection();
    var results = await conn.query(
        "SELECT giustificata, data_inizio, data_fine "
            "FROM assenze "
            "WHERE assenze.id_studente = $idUtente");
    await conn.close();
    return results.map((row) => row.fields).toList();
  }

/*
formato:
- DateTime scadenza
- String descrizione
- String nome (del docente)
- String cognome (del docente)
- String nome_materia
 */
  Future<List<Map<String, dynamic>>?> getCompiti(int idClasse) async {
    var db = Mysql();
    final conn = await db.getConnection();
    var results = await conn.query(
        "SELECT scadenza, descrizione, nome, cognome, nome_materia "
            "FROM compiti "
            "INNER JOIN assegnazioni ON compiti.id_assegnazione = assegnazioni.id_assegnazione "
            "INNER JOIN classi ON assegnazioni.id_classe = classi.id_classe "
            "INNER JOIN docenti ON assegnazioni.id_docente = docenti.id_docente "
            "INNER JOIN materie ON assegnazioni.id_materia = materie.id_materia "
            "WHERE assegnazioni.id_classe = $idClasse ");
    await conn.close();
    return results.map((row) => row.fields).toList();
  }

/*
formato:
- String nome (del docente)
- String cognome (del docente)
- String nome_materia
 */
  Future<List<Map<String, dynamic>>?> getDocenti(int idClasse) async {
    var db = Mysql();
    final conn = await db.getConnection();
    var results = await conn.query(
        "SELECT nome, cognome, nome_materia "
            "FROM assegnazioni "
            "INNER JOIN docenti ON assegnazioni.id_docente = docenti.id_docente "
            "INNER JOIN materie ON assegnazioni.id_materia = materie.id_materia "
            "WHERE assegnazioni.id_classe = $idClasse");
    await conn.close();
    return results.map((row) => row.fields).toList();
  }

/*
formato:
- int id_assegnazione 
- String nome_classe
- String nome_materia
 */
  Future<List<Map<String, dynamic>>?> getClassi() async {
    var db = Mysql();
    final conn = await db.getConnection();
    var results = await conn.query(
        "SELECT id_assegnazione, nome_classe, nome_materia "
            "FROM assegnazioni "
            "INNER JOIN docenti ON assegnazioni.id_docente = docenti.id_docente "
            "INNER JOIN materie ON assegnazioni.id_materia = materie.id_materia "
            "INNER JOIN classi ON assegnazioni.id_classe = classi.id_classe "
            "WHERE assegnazioni.id_docente = $idUtente_");
    await conn.close();
    return results.map((row) => row.fields).toList();
  }

/*
formato:
- int id_studente
- String nome (dello studente)
- String cognome (dello studente)
 */
  Future<List<Map<String, dynamic>>?> getStudenti(int idClasse) async {
    var db = Mysql();
    final conn = await db.getConnection();
    var results = await conn.query(
        "SELECT id_studente, nome, cognome, classi.id_classe"
            "FROM studenti "
            "INNER JOIN classi ON classi.id_classe = studenti.id_classe"
            "WHERE classi.id_classe = $idClasse");
    await conn.close();
    return results.map((row) => row.fields).toList();
  }


/*
formato:
- String nome_classe
_ String nome_materia
- Time ora_inizio
- Time ora_fine, giorno
- String giorno
*/


  Future<List<Map<String, dynamic>>?> getOreDocenti() async {
    var db = Mysql();
    final conn = await db.getConnection();
    var results = await conn.query(
        "SELECT nome_classe, nome_materia, ora_inizio, ora_fine, giorno"
            "FROM orari_assegnazioni"
            "INNER JOIN assegnazioni ON orari_assegnazioni.id_assegnazione = assegnazioni.id_assegnazione"
            "INNER JOIN materie ON assegnazioni.id_materia = materie.id_materia"
            "INNER JOIN classi ON assegnazioni.id_classe = classi.id_classe"
            "INNER JOIN giorni ON orari_assegnazioni.id_giorno = giorni.id_giorno"
            "WHERE assegnazioni.id_docente = $idUtente_");
    await conn.close();
    return results.map((row) => row.fields).toList();
  }
}