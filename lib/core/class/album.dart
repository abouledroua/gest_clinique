import 'enfant.dart';
import 'enseignant.dart';
import 'section.dart';
import 'parent.dart';
import 'classe.dart';

class Album {
  int id, etat, nbImage, visibilite, nbImageApprove;
  String date, designation, cheminDernierImage;
  List<String> strSections, strParents, strEnfants, strClasses, strEnseigants;
  List<Section> sections = [];
  List<Classe> classes = [];
  List<Enfant> enfants = [];
  List<Parent> parents = [];
  List<Enseignant> enseignants = [];
  bool existImageAprouve;
  Album(
      {required this.id,
      required this.nbImage,
      required this.date,
      required this.nbImageApprove,
      required this.existImageAprouve,
      required this.strEnseigants,
      required this.strSections,
      required this.strClasses,
      required this.strParents,
      required this.strEnfants,
      required this.designation,
      required this.visibilite,
      required this.cheminDernierImage,
      required this.etat});
}
