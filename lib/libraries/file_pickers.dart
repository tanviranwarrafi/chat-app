import 'dart:io';

import 'package:app/constants/data_constants.dart';
import 'package:file_picker/file_picker.dart';

FileType _type = FileType.custom;

class FilePickers {
  Future<File?> pickSingleFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true, type: _type, allowedExtensions: FILE_EXTENSIONS);
    if (result != null && result.files.length > 0) return File(result.files.single.path!);
    return null;
  }

  Future<List<File>> pickMultipleFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true, type: _type, allowedExtensions: FILE_EXTENSIONS);
    if (result != null && result.files.length > 0) return result.paths.map((file) => File(file!)).toList();
    return [];
  }
}
