class Enfant {
  String nom, prenom, fullName, dateNaiss, adresse, photo;
  int id, sexe, etat;
  bool isHomme, isFemme;
  Enfant(
      {required this.id,
      required this.etat,
      required this.nom,
      required this.prenom,
      required this.fullName,
      required this.isHomme,
      required this.isFemme,
      required this.dateNaiss,
      required this.adresse,
      required this.sexe,
      required this.photo});
}
