import 'dart:typed_data';

class ImageHelper {
  static Uint8List? _image;

  static void setImage(Uint8List image) {
    _image = image;
  }

  static Uint8List? getImage() {
    return _image;
  }
}
