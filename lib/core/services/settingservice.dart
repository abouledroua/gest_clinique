import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingServices extends GetxService {
  late SharedPreferences sharedPrefs;
  late PackageInfo packageInfo;

  Future<SettingServices> init() async {
    sharedPrefs = await SharedPreferences.getInstance();
    packageInfo = await PackageInfo.fromPlatform();
    return this;
  }
}
