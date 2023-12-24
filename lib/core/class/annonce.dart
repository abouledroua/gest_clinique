import 'enfant.dart';
import 'section.dart';
import 'parent.dart';
import 'classe.dart';

class Annonce {
  String titre, detail, date, heure;
  int id, etat, visiblite;
  DateTime dateTime;
  List<String> strSections, strParents, strEnfants, strClasses;
  List<Section> sections = [];
  List<Classe> classes = [];
  List<Enfant> enfants = [];
  List<Parent> parents = [];
  bool pin;
  Annonce(
      {required this.id,
      required this.pin,
      required this.dateTime,
      required this.visiblite,
      required this.strParents,
      required this.strEnfants,
      required this.strClasses,
      required this.strSections,
      required this.titre,
      required this.detail,
      required this.date,
      required this.heure,
      required this.etat});
}
