class Patient {
  String nom,
      prenom,
      fullname,
      codeBarre,
      profession,
      dateNaissance,
      lieuNaissance,
      tel1,
      adresse,
      codeMalade,
      tel2,
      email;
  int age, typeAge, sexe, gs;
  bool convention, isHomme, isFemme;
  double prcConvention, dette;

  Patient(
      {required this.nom,
      required this.prenom,
      required this.fullname,
      required this.codeMalade,
      required this.isHomme,
      required this.isFemme,
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
      required this.dette,
      required this.gs,
      required this.tel1,
      required this.tel2});

  String getSexe() => (isHomme) ? 'Homme' : 'Femme';

  String getGS() => (gs == -1 || gs == 0)
      ? ''
      : gs == 1
          ? 'A+'
          : gs == 2
              ? 'A-'
              : gs == 3
                  ? 'B+'
                  : gs == 4
                      ? 'B-'
                      : gs == 5
                          ? 'AB+'
                          : gs == 6
                              ? 'AB-'
                              : gs == 7
                                  ? 'O+'
                                  : 'O-';
}
