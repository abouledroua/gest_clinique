import 'patient.dart';

class RDV {
  Patient patient;
  String dateRdv, dateDernConsult;
  int etat;
  RDV(
      {required this.patient,
      required this.dateRdv,
      required this.etat,
      required this.dateDernConsult});
}
