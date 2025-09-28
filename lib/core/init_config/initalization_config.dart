import 'package:new_strucuture/app_bloc_observer.dart';
import 'package:new_strucuture/config/themes/theme_noti.dart';
import 'package:new_strucuture/core/exports.dart';
import 'package:new_strucuture/core/notification_services/notification_service.dart';
import 'package:new_strucuture/core/utils/connectivity/connectivity.dart';
import 'package:new_strucuture/core/utils/system_ui.dart';
import 'package:new_strucuture/firebase_options.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:new_strucuture/injector.dart' as injector;
import '../preferences/preferences.dart';

Future<void> initializationClass() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  NotificationService notificationService = NotificationService();
  await EasyLocalization.ensureInitialized();
  await ScreenUtil.ensureScreenSize();

  AndroidOptions getAndroidOptions() =>
      const AndroidOptions(encryptedSharedPreferences: true);
  IOSOptions getIOSOptions() =>
      const IOSOptions(accessibility: KeychainAccessibility.first_unlock);

  prefs = await SharedPreferences.getInstance();
  SystemUiStyle.overlayStyle();
  await ThemeNotifier.init();
  await ConnectivityHandler().checkConnection();

  secureStorage = FlutterSecureStorage(
      aOptions: getAndroidOptions(), iOptions: getIOSOptions());
  await notificationService.initialize();

  await injector.setupDependencyInjection();
  await injector.setupCubit();
  await injector.setupRepo();
  Bloc.observer = AppBlocObserver();

  await ConnectivityHandler().checkConnection();
}
