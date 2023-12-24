class Parent {
  String nom,
      prenom,
      fullName,
      dateNaiss,
      email,
      adresse,
      tel1,
      tel2,
      userName,
      password;
  int id, sexe, idUser, etat;
  bool isHomme, isFemme, isActive;
  Parent(
      {required this.id,
      required this.nom,
      required this.prenom,
      required this.fullName,
      required this.isActive,
      required this.email,
      required this.password,
      required this.userName,
      required this.etat,
      required this.idUser,
      required this.isHomme,
      required this.isFemme,
      required this.dateNaiss,
      required this.adresse,
      required this.sexe,
      required this.tel2,
      required this.tel1});
}
