class Photo {
  int id, etat;
  bool select;
  String date, heure, cheminBig, cheminSmall;
  Photo(
      {required this.id,
      required this.etat,
      required this.date,
      required this.select,
      required this.heure,
      required this.cheminBig,
      required this.cheminSmall});
}
