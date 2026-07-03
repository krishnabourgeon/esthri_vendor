import 'package:elaveoironing_vendor/services/network/base_services.dart';
import 'package:get_it/get_it.dart';
import 'package:elaveoironing_vendor/res/app_config.dart';
import 'package:elaveoironing_vendor/services/shared_prefernce/shared_prefs.dart';
import 'package:elaveoironing_vendor/utils/helper/helpers.dart';

class AuthServices {
  static String? mob;
  static String? tok;
  final services = GetIt.instance<BaseServices>();
  final sharedPrefs = GetIt.instance<SharedPrefs>();
  Future<bool?> logIn({String? phone, String? password}) async {
    final res = await services.logIn(phone: phone, password: password);
    if (res.isLeft) {
      print(res.left.message);
      Helpers.showToast(res.left.message ?? "");
      return false;
    } else if (res.isRight) {
      if (res.right["status"]) {
        print("................${res.right["token"]}");
        final token = res.right["token"]?.toString() ?? '';
        final user = res.right["user"];
        final name = user?["name"]?.toString() ?? '';
        final id = user?["id"] is int
            ? user["id"] as int
            : int.tryParse('${user?["id"]}') ?? 0;
        final deliveryAgent = res.right["site_settings"]?["delivery_agent"];
        final settings = deliveryAgent is int
            ? deliveryAgent
            : int.tryParse('$deliveryAgent') ?? 0;

        sharedPrefs.saveAuthToken(token: token);
        sharedPrefs.savephone(name: name);
        sharedPrefs.saveactive(active: true);
        sharedPrefs.savesettings(settings: settings);
        sharedPrefs.saveid(id: id);
        AppConfig.id = id;
        AppConfig.authToken = "Bearer $token";
        AppConfig.name = name;
        AppConfig.isactive = true;
        AppConfig.settings = settings;
        return true;
      } else {
        return false;
      }
    } else {
      return null;
    }
  }

  // Future<bool?> changestatus({int? status, int? orderid}) async {
  //   final res = await services.changestatus(status: status, orderid: orderid);
  //   if (res.isLeft) {
  //     print(res.left.message);
  //     Helpers.showToast(res.left.message ?? "");
  //     return false;
  //   } else if (res.isRight) {
  //     if (res.right["status"]) {
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   } else {
  //     return null;
  //   }
  // }

  // Future<bool?> updateactive({
  //   int? status,
  // }) async {
  //   final res = await services.updateactive(
  //     status: status,
  //   );
  //   if (res.isLeft) {
  //     print(res.left.message);
  //     Helpers.showToast(res.left.message ?? "");
  //     return false;
  //   } else if (res.isRight) {
  //     if (res.right["status"]) {
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   } else {
  //     return null;
  //   }
  // }
}
