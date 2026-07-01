import 'package:get_it/get_it.dart';
import 'package:elaveoironing_vendor/services/network/base_services.dart';
import 'package:elaveoironing_vendor/services/shared_prefernce/shared_prefs.dart';
import 'package:elaveoironing_vendor/utils/helper/helpers.dart';

class HomeServices {
  final services = GetIt.instance<BaseServices>();
  final sharedPrefs = GetIt.instance<SharedPrefs>();

  Future<bool?> changestatus({int? status, int? orderid}) async {
    final res = await services.changestatus(status: status, orderid: orderid);
    if (res.isLeft) {
      print(res.left.message);
      Helpers.showToast(res.left.message ?? "");
      return false;
    } else if (res.isRight) {
      if (res.right["status"]) {
        return true;
      } else {
        return false;
      }
    } else {
      return null;
    }
  }

  Future<bool?> updateactive({
    int? status,
  }) async {
    final res = await services.updateactive(
      status: status,
    );
    if (res.isLeft) {
      print(res.left.message);
      Helpers.showToast(res.left.message ?? "");
      return false;
    } else if (res.isRight) {
      if (res.right["status"]) {
        return true;
      } else {
        return false;
      }
    } else {
      return null;
    }
  }

  Future<bool?> locationupdate({double? latitude, double? longitude}) async {
    final res =
        await services.locationupdate(latitude: latitude, longitude: longitude);
    if (res.isLeft) {
      print(res.left.message);
      Helpers.showToast(res.left.message ?? "");
      return false;
    } else if (res.isRight) {
      if (res.right["status"]) {
        Helpers.showToast(res.right["message"] ?? "");
        return true;
      } else {
        return false;
      }
    } else {
      return null;
    }
  }

  Future<bool?> logout() async {
    final res = await services.logout();
    if (res.isLeft) {
      Helpers.showToast(res.left.message ?? "");
      return false;
    } else if (res.isRight) {
      if (res.right["status"] == "true") {
        return true;
      } else {
        Helpers.showToast(res.right["message"]);
        return false;
      }
    } else {
      return null;
    }
  }

  Future<bool?> complaint(
      {int? orderid, String? desc, int? orderitemid}) async {
    print(orderid);
    print(desc);
    print(orderitemid);
    final res = await services.complaint(
      orderid: orderid,
      orderitemid: orderitemid,
      desc: desc,
    );
    if (res.isLeft) {
      Helpers.showToast(res.left.message ?? "");
      return false;
    } else if (res.isRight) {
      if (res.right["status"]) {
        Helpers.showToast(res.right["message"]);
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}
