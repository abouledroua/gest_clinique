class Enseignant {
  String nom,
      prenom,
      fullName,
      dateNaiss,
      adresse,
      email,
      tel1,
      matiere,
      userName,
      password;
  int id, sexe, idUser, etat;
  bool isHomme, isFemme, isActive;
  Enseignant(
      {required this.id,
      required this.email,
      required this.nom,
      required this.prenom,
      required this.isActive,
      required this.fullName,
      required this.etat,
      required this.password,
      required this.userName,
      required this.idUser,
      required this.isHomme,
      required this.isFemme,
      required this.dateNaiss,
      required this.adresse,
      required this.sexe,
      required this.matiere,
      required this.tel1});
}
