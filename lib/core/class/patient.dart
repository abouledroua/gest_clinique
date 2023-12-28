class Patient {
  String nom,
      prenom,
      codeBarre,
      profession,
      dateNaissance,
      lieuNaissance,
      tel1,
      adresse,
      tel2,
      email;
  int age, typeAge, sexe, gs;
  bool convention;
  double prcConvention;

  Patient(
      {required this.nom,
      required this.prenom,
      required this.codeBarre,
      required this.email,
      required this.dateNaissance,
      required this.adresse,
      required this.lieuNaissance,
      required this.profession,
      required this.age,
      required this.typeAge,
      required this.convention,
      required this.prcConvention,
      required this.sexe,
      required this.gs,
      required this.tel1,
      required this.tel2});
}
