class ImageAnnounce {
  late String base64ImageBig, base64ImageSmall, extension;
  bool upload;
  int idAnnonce;
  ImageAnnounce(
      {required this.base64ImageBig,
      required this.base64ImageSmall,
      required this.extension,
      required this.upload,
      required this.idAnnonce});
}
