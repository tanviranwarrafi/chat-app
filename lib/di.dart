import 'package:app/helpers/dimension_helper.dart';
import 'package:app/helpers/file_helper.dart';
import 'package:app/libraries/flush_popup.dart';
import 'package:app/libraries/formatters.dart';
import 'package:app/libraries/image_croppers.dart';
import 'package:app/libraries/image_pickers.dart';
import 'package:app/libraries/local_storage.dart';
import 'package:app/libraries/toasts_popups.dart';
import 'package:app/repositories/chat_repository.dart';
import 'package:app/services/image_service.dart';
import 'package:app/services/storage_service.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /// Helpers
  sl.registerLazySingleton<DimensionHelper>(DimensionHelper.new);
  sl.registerLazySingleton<FileHelper>(FileHelper.new);

  /// Libraries
  sl.registerLazySingleton<FlushPopup>(FlushPopup.new);
  sl.registerLazySingleton<Formatters>(Formatters.new);
  sl.registerLazySingleton<ImageCroppers>(ImageCroppers.new);
  sl.registerLazySingleton<ImagePickers>(ImagePickers.new);
  sl.registerLazySingleton<LocalStorage>(LocalStorage.new);
  sl.registerLazySingleton<ToastPopup>(ToastPopup.new);

  /// Repositories
  sl.registerLazySingleton<ChatRepository>(ChatRepository.new);

  /// Services
  sl.registerLazySingleton<ImageService>(ImageService.new);
  sl.registerLazySingleton<StorageService>(StorageService.new);
}
