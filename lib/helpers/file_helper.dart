import 'dart:convert';
import 'dart:io';

import 'package:app/di.dart';
import 'package:app/extensions/flutter_ext.dart';
import 'package:app/extensions/string_ext.dart';
import 'package:app/models/system/doc_file.dart';
import 'package:app/services/image_service.dart';
import 'package:http/http.dart' as http;

class FileHelper {
  String getFileType(String? path) {
    if (path == null) return '';
    final index = path.lastIndexOf('.');
    if (index < 0 || index + 1 >= path.length) return path;
    return path.substring(index + 1).toLower;
  }

  /*String getFileBasedIcon(String? path) {
    if (path == null) return Assets.svg.file_text;
    var fileType = getFileType(path).toLower;
    return fileType == 'png' || fileType == 'jpg' || fileType == 'jpeg' || fileType == 'bmp'
        ? Assets.svg.image_square
        : Assets.svg.file_text;
  }*/

  int totalFileSize(List<DocFile?> files) {
    var size = 0;
    files.forEach((item) => size = item?.size == null ? 0 : size = item!.size);
    return size < 1 ? 0 : size ~/ (1024 * 1024);
  }

  Future<bool> isLargeFile(File file) async {
    int fileSizeInBytes = await file.length();
    int fileSizeInKB = fileSizeInBytes ~/ 1024;
    return fileSizeInKB > 5120;
  }

  bool isDuplicateFile(List<DocFile> files, File file) {
    int count = 0;
    files.forEach((item) => item.file?.path != null && item.file!.path == file.path ? count = count + 1 : null);
    return count > 1;
  }

  Future<List<DocFile>> renderFilesInModel(List<File> files) async {
    List<DocFile> proofFiles = [];
    if (!files.haveList) return proofFiles;
    for (File item in files) {
      // var fileType = getFileType(item.path);
      var isValid = true /*FILE_EXTENSIONS.contains(fileType)*/;
      var isLarge = await isLargeFile(item);
      var unit8list = await sl<ImageService>().fileToUnit8List(item);
      var b64 = base64.encode(unit8list!);
      var sizeInBytes = await item.length();
      proofFiles.add(DocFile(file: item, isLarge: isLarge, base64: b64, isValid: isValid, unit8List: unit8list, size: sizeInBytes));
    }
    return proofFiles;
  }

  Future<List<http.MultipartFile>> getMultipartFiles(String key, List<DocFile> images) async {
    List<http.MultipartFile> multipartFiles = [];
    for (DocFile item in images) {
      multipartFiles.add(await http.MultipartFile.fromPath(key, item.file!.path));
    }
    return multipartFiles;
  }
}
