import 'dart:io';

import 'package:image_picker/image_picker.dart';

Future<File?> pickImage() async {
  final xFile = await ImagePicker().pickImage(source: ImageSource.camera);
  print(xFile?.name ?? "NODATA");
  return (xFile != null) ? File(xFile.path) : null;
}
