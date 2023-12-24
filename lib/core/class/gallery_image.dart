import 'package:image_picker/image_picker.dart';

class GalleryImage {
  int idAlbum;
  XFile file;
  bool upload;
  String filename;
  GalleryImage(
      {required this.file,
      required this.idAlbum,
      required this.upload,
      required this.filename});
}
