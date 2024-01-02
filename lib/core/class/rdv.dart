class RDV {
  String codeBarre, nom, prenom, motif;
  double versement, dette;
  bool consult;
  int etatRDV, age, typeAge, sexe;
  RDV(
      {required this.codeBarre,
      required this.sexe,
      required this.typeAge,
      required this.age,
      required this.etatRDV,
      required this.consult,
      required this.dette,
      required this.versement,
      required this.nom,
      required this.prenom,
      required this.motif});
}
