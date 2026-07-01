import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:elaveoironing_vendor/datamodel/count_datamodel.dart';
import 'package:elaveoironing_vendor/datamodel/getcomplaint_datamodel.dart';
import 'package:elaveoironing_vendor/datamodel/pending_datamodel.dart';
import 'package:elaveoironing_vendor/datamodel/profile_datamodel.dart';
import 'package:elaveoironing_vendor/datamodel/report_datamodel.dart';
import 'package:elaveoironing_vendor/datamodel/version_datamodel.dart';
import 'package:elaveoironing_vendor/res/app_config.dart';
import 'package:elaveoironing_vendor/services/network/api_request.dart';
import 'package:elaveoironing_vendor/services/network/base_services.dart';
import 'package:elaveoironing_vendor/utils/helper/helpers.dart';

class HomeProvider extends ChangeNotifier {
  final services = GetIt.instance<BaseServices>();
  DateTime? selectedfromDate = DateTime.now();
  DateTime? selectedtoDate = DateTime.now();
  updatefromdate(date) {
    selectedfromDate = date;
    print("..selected/..$selectedfromDate");
    notifyListeners();
  }

  LoaderState locationLoaderState = LoaderState.loaded;
  void updatelocationLoaderState(LoaderState state) {
    locationLoaderState = state;
    notifyListeners();
  }

  LoaderState profileLoaderState = LoaderState.loaded;
  void updateprofileLoaderState(LoaderState state) {
    profileLoaderState = state;
    notifyListeners();
  }

  updatecount(id, index) async {
    await getcomplaint(orderid: id);
    pendingdata?.orders![index].count = getcomplaintdata?.feedbacks?.length;

    notifyListeners();
  }

  Position? currentPosition;
  updateposition() async {
    updatelocationLoaderState(LoaderState.loading);
    Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
      accuracy: LocationAccuracy.high,
    ));
    currentPosition = position;
    print(currentPosition);
    notifyListeners();
  }

  update() {
    updatelocationLoaderState(LoaderState.loaded);
    notifyListeners();
  }

  updatetodate(date) {
    selectedtoDate = date;
    print("..selected/..$selectedtoDate");

    notifyListeners();
  }

  bool _switchValue = true;
  bool _changeval = true;

  bool get switchValue => _switchValue;
  bool get changeval => _changeval;

  void updateSwitchValue(bool newValue) {
    sharedPrefs.saveactive(active: newValue);
    AppConfig.isactive = newValue;
    notifyListeners();
  }

  double total = 0;
  totalamount(val) {
    print(val);
    total = total + val;
    print("..total..$total");
    notifyListeners();
  }

  void updateval(bool newValue) {
    _changeval = newValue;
    notifyListeners();
  }

  LoaderState PendingLoaderState = LoaderState.loaded;
  void updatependingLoaderState(LoaderState state) {
    PendingLoaderState = state;
    notifyListeners();
  }

  LoaderState reportLoaderState = LoaderState.loaded;
  void updatereportLoaderState(LoaderState state) {
    reportLoaderState = state;
    notifyListeners();
  }

  LoaderState pickupmsgcountloaderState = LoaderState.loaded;
  void updatepickupmsgcountLoaderState(LoaderState state) {
    pickupmsgcountloaderState = state;
    notifyListeners();
  }

  PendingDatamodel? pendingdata;
  Future<void> pending({required int? status}) async {
    pendingdata = null;
    print("..branch... ...$status");
    updatependingLoaderState(LoaderState.loading);
    final network = await Helpers.isInternetAvailable();
    if (network) {
      await services.pending(status: status).fold(
        (left) {
          updatependingLoaderState(LoaderState.error);
        },
        (right) {
          pendingdata = right;
          print(pendingdata?.orders?.length);
          updatepickupmsgcountLoaderState(LoaderState.loading);
          pendingdata!.orders?.asMap().forEach((index, order) async {
            int id = order.orderId ?? 0;
            await updatecount(id, index);
          });
          notifyListeners();
          updatepickupmsgcountLoaderState(LoaderState.loaded);

          updatependingLoaderState(LoaderState.loaded);
        },
      ).catchError((error) {
        updatependingLoaderState(LoaderState.error);

        debugPrint(error.toString());
      });
    } else {
      updatependingLoaderState(LoaderState.networkError);
    }
  }

  GetcomplaintDatamodel? getcomplaintdata;
  Future<void> getcomplaint({int? orderid, int? shopid}) async {
    final network = await Helpers.isInternetAvailable();
    if (network) {
      await services.getcomplaint(orderid: orderid, shopid: shopid).fold(
        (left) {
          // updatependingLoaderState(LoaderState.error);
        },
        (right) {
          getcomplaintdata = right;

          notifyListeners();

          // updatependingLoaderState(LoaderState.loaded);
        },
      ).catchError((error) {
        // updatependingLoaderState(LoaderState.error);

        debugPrint(error.toString());
      });
    } else {
      // updatependingLoaderState(LoaderState.networkError);
    }
  }

  ReportDatamodel? reportdata;
  Future<void> report({String? fromdata, String? todate}) async {
    print("...$fromdata...$todate");
    reportdata = null;
    updatereportLoaderState(LoaderState.loading);
    final network = await Helpers.isInternetAvailable();
    if (network) {
      await services.report(fromdata: fromdata, todate: todate).fold(
        (left) {
          updatereportLoaderState(LoaderState.error);
        },
        (right) {
          reportdata = right;

          notifyListeners();

          updatereportLoaderState(LoaderState.loaded);
        },
      ).catchError((error) {
        updatereportLoaderState(LoaderState.error);

        debugPrint(error.toString());
      });
    } else {
      updatereportLoaderState(LoaderState.networkError);
    }
  }

  CountDatamodel? countdata;
  Future<void> getcount() async {
    countdata = null;
    final network = await Helpers.isInternetAvailable();
    if (network) {
      await services.getcount().fold(
        (left) {
          // updatereportLoaderState(LoaderState.error);
        },
        (right) {
          countdata = right;

          notifyListeners();

          // updatereportLoaderState(LoaderState.loaded);
        },
      ).catchError((error) {
        // updatereportLoaderState(LoaderState.error);

        debugPrint(error.toString());
      });
    } else {
      // updatereportLoaderState(LoaderState.networkError);
    }
  }

  VersionDatamodel? version;
  Future<void> getversion() async {
    version = null;

    final network = await Helpers.isInternetAvailable();
    if (network) {
      await services.getversion().fold(
        (left) {},
        (right) {
          version = right;
          notifyListeners();
        },
      ).catchError((error) {
        debugPrint(error.toString());
      });
    } else {}
  }

  ProfileDatamodel? profile;
  Future<void> getprofile() async {
    updateprofileLoaderState(LoaderState.loading);
    profile = null;

    final network = await Helpers.isInternetAvailable();
    if (network) {
      await services.getprofile().fold(
        (left) {
          updateprofileLoaderState(LoaderState.error);
        },
        (right) {
          profile = right;
          notifyListeners();
          updateprofileLoaderState(LoaderState.loaded);
        },
      ).catchError((error) {
        updateprofileLoaderState(LoaderState.error);

        debugPrint(error.toString());
      });
    } else {}
  }

  final List<String> complaints = [
    "Damage Complaints",
    "Stain-Related Complaints",
    "Odor Complaints",
    "Misplacement and Loss Complaints",
    "Ironing and Folding Issues",
    "Packing and Delivery Complaints",
    "Miscellaneous Complaints",
  ];

  String? selectedComplaint;
  updatecomplaint(val) {
    selectedComplaint = val;
    notifyListeners();
  }
}
