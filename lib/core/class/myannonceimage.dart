import 'dart:typed_data';

class MyAnnonceImage {
  late String chemin;
  late Uint8List? imageDataBig, imageDataSmall;
  int num;
  MyAnnonceImage(
      {required this.chemin,
      required this.num,
      required this.imageDataBig,
      required this.imageDataSmall});
}
